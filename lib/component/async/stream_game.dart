import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_flutter/component/layout/key_game.dart';

class StreamGame extends StatefulWidget {
  const StreamGame({Key? key}) : super(key: key);

  @override
  _StreamGameState createState() => _StreamGameState();
}

class _StreamGameState extends State<StreamGame> {
  final _streamController = StreamController.broadcast();
  final _scoreController = StreamController.broadcast();
  int _score = 0;

  @override
  void dispose() {
    _streamController.close();
    _scoreController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: StreamBuilder(
            stream: _streamController.stream.distinct(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Text("${snapshot.data}");
              }
              return Text("waiting");
            },
          ),
          actions: [
            StreamBuilder(
              stream: _scoreController.stream.transform(MiddleStreamTransform()),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                   _score = snapshot.data as int;
                }
                return Chip(label: Text("$_score"));
              },
            )
          ],
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201302%2F14%2F20130214211827_4MJza.thumb.700_0.png&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1630830550&t=77a57fb99f800071d24b2154837940ff"),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              ...List.generate(
                  5,
                  (index) => Puzzle(
                      inputStream: _streamController.stream,
                      scoreController: _scoreController)),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Keypad(
                    streamController: _streamController,
                  )),
            ],
          ),
        ));
  }
}

class Keypad extends StatelessWidget {
  final StreamController streamController;

  Keypad({
    Key? key,
    required this.streamController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // padding: EdgeInsets.all(8),
      ///不占满屏幕以子元素的尺寸为准
      shrinkWrap: true,
      itemCount: 9,

      ///ios下面有部分区域
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        // mainAxisSpacing: 10,
        // crossAxisSpacing: 10,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // color: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
          color: Colors.primaries[index][300],
          child: TextButton(
            onPressed: () {
              streamController.sink.add(index + 1);
            },
            child: Text(
              "${index + 1}",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

///中间人 可以在对stream 进行一次包装  类似map filter
class MiddleStreamTransform implements StreamTransformer{
  int sum=0;
  StreamController _streamController =StreamController();
  @override
  Stream bind(Stream<dynamic> stream) {
   stream.listen((event) {
     sum=sum+(event as int);
     _streamController.add(sum);
   });
   return _streamController.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

}

class Puzzle extends StatefulWidget {
  final Stream inputStream;
  final StreamController scoreController;

  Puzzle({Key? key, required this.inputStream, required this.scoreController})
      : super(key: key);

  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  int a = 0, b = 0;
  double _left = 0;
  late Duration _duration;
  late AnimationController _animationController;
  late AnimationController _animationController2;
  late Animation<double> _scale;
  double _top = 0.0;
  bool _clickLock = true;
  bool _ignore = false;

  getNumber() {
    a = Random().nextInt(9);
    b = Random().nextInt(9);
    if (a + b > 9 || a + b == 0) {
      getNumber();
    }
  }

  bool flag = false;

  reset() {
    getNumber();
    _ignore=false;
    _duration = Duration(seconds: Random().nextInt(5) +3);
    _animationController.duration = _duration;
    _scale = Tween(begin: 1.0, end: 1.0).animate(_animationController);
    _left = 300 * Random().nextDouble();
  }

  @override
  void initState() {
    ///this 只有在方法里面有
    _animationController = AnimationController(vsync: this);
    reset();
    //from是百分比  一开始的时候不要从0开始
    // _animationController.forward(from: Random().nextDouble());
    _animationController.forward(from: 0.0);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if(_ignore==false){
          widget.scoreController.add(-1);
        }
        setState(() {
          flag = false;
        });
        reset();
        _animationController.forward(from: 0.0);
      }
    });

    widget.inputStream.listen((event) {
      if (_clickLock) {
        if (event == (a + b)) {
          _ignore=true;
          _clickLock = false;
          widget.scoreController.add(1);
          _top = _animationController.value * 600 - 100;
          setState(() {
            flag = true;
          });
          _animationController.stop();
          _animationController.duration = Duration(seconds: 2);
          _scale = Tween(begin: 1.0, end: 2.0).animate(_animationController);
          _animationController.forward(from: 0.0);
          Future.delayed(Duration(milliseconds: 1000), () {
            _scale = Tween(begin: 2.0, end: 0.0).animate(_animationController);
          });
          Future.delayed(Duration(milliseconds: 2000), () {
            _clickLock = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          top: flag == false ? _animationController.value * 600 - 100 : _top,
          // top:_animationController.value *600 - 100 ,
          left: _left,
          child: ScaleTransition(
            scale: _scale,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://img0.baidu.com/it/u=2592942477,2257280665&fm=26&fmt=auto&gp=0.jpg"),
                    fit: BoxFit.contain),
                gradient: LinearGradient(
                  tileMode: TileMode.mirror,
                  colors: [
                    (Colors.primaries[a][200])!,
                    (Colors.primaries[b][200])!
                  ],
                ),
                border: Border.all(color: (Colors.primaries[a + b][200])!),
                // borderRadius: BorderRadius.circular(16),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: (Colors.primaries[a + b][200])!, blurRadius: 3)
                ],
              ),
              child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: Text(
                  flag == true ? "成功了" : "$a+$b",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
