import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_flutter/component/title_divider.dart';

class KeyGame extends StatefulWidget {
  KeyGame({Key? key}) : super(key: key);

  @override
  _KeyGameState createState() => _KeyGameState();
}

class _KeyGameState extends State<KeyGame> {
  // List<Color> colors = [
  //   (Colors.red[100])!,
  //   (Colors.red[200])!,
  //   (Colors.red[300])!,
  //   (Colors.red[400])!,
  //   (Colors.red[500])!,
  //   (Colors.red[600])!,
  //   (Colors.red[700])!,
  //   (Colors.red[800])!,
  // ];
  List<Color> colors = [];
  var _color = Colors.primaries[Random().nextInt(Colors.primaries.length - 1)];

  int _dragIndex = 0;

  _shuffle() {
    ///Shuffles(洗牌) the elements of this list randomly.
    setState(() {
      _color = Colors.primaries[Random().nextInt(Colors.primaries.length - 1)];
      colors = List.generate(5, (index) => (_color[(index + 1) * 100])!);
      colors.shuffle();
    });
  }

  _checkWinCondition() {
  /*
  int compare(Color a, Color b) {
      return a.value - b.value;
    }
    List<Color> temp = [];
    temp.addAll(colors);
    temp.sort(compare);
    int flag = 1;
    for (int i = 0; i < colors.length; i++) {
      if (colors[i] != temp[i]) {
        flag = 0;
      }
    }
    */

    bool success=true;

    for (int i = 0; i < colors.length-1; i++) {
      print(i);
      print(colors[i].computeLuminance());
      if (colors[i].computeLuminance() > colors[i+1].computeLuminance()) {
        success=false;
        break;
      }
    }
  print(success);
    if (success) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("congratulations"),
            content: Container(
              height: 80,
                alignment: Alignment.center,
                child: Text("you win",style: TextStyle(fontSize: 50,color: Colors.pinkAccent),)),
            actions: [
              TextButton(
                  onPressed: () {
                    _shuffle();
                    Navigator.pop(context);
                  },
                  child: Text("play again"))
            ],
          );
        },
      );
    }
  }

  GlobalKey _globalKey = GlobalKey();
  GlobalKey _horiGlobalKey = GlobalKey();

  @override
  void initState() {
    colors = List.generate(5, (index) => (_color[(index + 1) * 100])!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "key game",
        ),
        centerTitle: true,
      ),

      ///监听触摸事件
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.red,
            alignment: Alignment.center,
            width: 500,
            height: 200,
            child: Container(
              width: Box.width * 8,
              color: Colors.orangeAccent,
              child: Listener(
                onPointerMove: (event) {
                  var renderBox = _horiGlobalKey.currentContext!
                      .findRenderObject() as RenderBox;
                  final offsetX = renderBox.localToGlobal(Offset.zero).dx;
                  final x = event.position.dx - offsetX;
                  // print(x);
                  // print(_dragIndex);
                  if (x > (_dragIndex + 1) * Box.width) {
                    if (_dragIndex == colors.length - 1) return;
                    setState(() {
                      Color temp = colors[_dragIndex];
                      colors[_dragIndex] = colors[_dragIndex + 1];
                      colors[_dragIndex + 1] = temp;
                      _dragIndex++;
                    });
                  } else if (x < (_dragIndex * Box.width)) {
                    if (_dragIndex == 0) return;
                    setState(() {
                      Color temp = colors[_dragIndex];
                      colors[_dragIndex] = colors[_dragIndex - 1];
                      colors[_dragIndex - 1] = temp;
                      _dragIndex--;
                    });
                  }
                },
                child: Stack(
                    key: _horiGlobalKey,
                    children: List.generate(colors.length, (index) {
                      return Box(

                          ///这边不能用index 每次打乱颜色顺序会重新build 顺序是随机的 index不能保证每次key的前后一致性
                          key: ValueKey(colors[index]),
                          color: colors[index],
                          left: index * Box.width,
                          top: 50.0,
                          onDrag: (Color color) {
                            int index = colors.indexOf(color);
                            _dragIndex = index;
                          },
                          onDragEnd: () {
                            _checkWinCondition();
                          });
                    })),
              ),
            ),
          ),
          TitleDivider(
            title: "vertical",
            margin: 0,
          ),
          Container(
            width: BoxVertical.width,
            child: Center(
              child: Container(
                width: BoxVertical.width,
                height: BoxVertical.height - BoxVertical.margin * 2,
                decoration: BoxDecoration(
                    color: _color[900],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 1,
                      )
                    ]),
                child: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            ///vertical Listener 计算的是相对与整个屏幕的高度
            child: Listener(
              onPointerMove: (event) {
                var renderBox =
                    _globalKey.currentContext!.findRenderObject() as RenderBox;
                final offset = renderBox.localToGlobal(Offset.zero).dy;

                final y = event.position.dy - offset;
                // print(offset);
                // print(y);
                if (y > (_dragIndex + 1) * BoxVertical.height) {
                  if (_dragIndex == colors.length - 1) return;
                  setState(() {
                    Color temp = colors[_dragIndex];
                    colors[_dragIndex] = colors[_dragIndex + 1];
                    colors[_dragIndex + 1] = temp;
                    _dragIndex++;
                  });
                } else if (y < (_dragIndex * BoxVertical.height)) {
                  if (_dragIndex == 0) return;
                  setState(() {
                    Color temp = colors[_dragIndex];
                    colors[_dragIndex] = colors[_dragIndex - 1];
                    colors[_dragIndex - 1] = temp;
                    _dragIndex--;
                  });
                }
              },
              child: SizedBox(
                width: BoxVertical.width,
                child: Stack(
                    key: _globalKey,
                    children: List.generate(colors.length, (index) {
                      return BoxVertical(
                        ///这边不能用index 每次打乱颜色顺序会重新build 顺序是随机的 index不能保证每次key的前后一致性
                        key: ValueKey(colors[index]),
                        color: colors[index],
                        top: index * BoxVertical.height,
                        left: 0,
                        onDrag: (Color color) {
                          int index = colors.indexOf(color);
                          _dragIndex = index;
                        },
                        onDragEnd: () {
                          _checkWinCondition();
                        },
                      );
                    })),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: _shuffle,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class Box extends StatelessWidget {
  final Color color;
  final double left;
  final double top;

  ///VoidCallback is just shorthand for void Function()
  ///VoidCallback 是的简写
  // final VoidCallback onDrag;
  ///从父组件接收一个函数  传个参数个这个函数并运行
  final Function(Color color) onDrag;

  ///有参数要出传的时候需要加括号
  final Function() onDragEnd;

  static const double width = 38.0;
  static const double height = 100.0;
  static const double margin = 4.0;

  const Box(
      {Key? key,
      required this.color,
      required this.left,
      this.top = 0.0,
      required this.onDrag,
      required this.onDragEnd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: width,
      child: Center(
        child: Container(
          width: width - margin * 2,
          height: height,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ]),
        ),
      ),
    );

    return AnimatedPositioned(
      left: left,
      top: top,
      duration: Duration(milliseconds: 100),
      child: Draggable(
          onDragStarted: () {
            onDrag(color);
          },
          onDragEnd: (details) {
            onDragEnd();
          },

          ///正在拖动中的部件
          feedback: container,

          ///拖动中的部件离开后留下的空位
          childWhenDragging: Visibility(visible: false, child: container),

          ///正常位置部件
          child: container),
    );
  }
}

class BoxVertical extends StatelessWidget {
  final Color color;
  final double left;
  final double top;

  ///VoidCallback is just shorthand for void Function()
  ///VoidCallback 是的简写
  // final VoidCallback onDrag;
  ///从父组件接收一个函数  传个参数个这个函数并运行
  final Function(Color color) onDrag;

  ///没有参数要出传的时候可以不加括号
  final Function onDragEnd;

  static const double width = 100.0;
  static const double height = 38;
  static const double margin = 4.0;

  const BoxVertical(
      {Key? key,
      required this.color,
      this.left = 0,
      required this.top,
      required this.onDrag,
      required this.onDragEnd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = Container(
      height: height,
      child: Center(
        child: Container(
          width: width,
          height: height - margin * 2,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ]),
        ),
      ),
    );

    return AnimatedPositioned(
      left: left,
      top: top,
      duration: Duration(milliseconds: 100),
      child: Draggable(
          onDragStarted: () {
            onDrag(color);
          },
          onDragEnd: (details) {
            onDragEnd();
          },

          ///正在拖动中的部件
          feedback: container,

          ///拖动中的部件离开后留下的空位
          childWhenDragging: Visibility(visible: false, child: container),

          ///正常位置部件
          child: container),
    );
  }
}

class ReorderListViewDemo extends StatelessWidget {
  const ReorderListViewDemo({
    Key? key,
    required this.boxes,
  }) : super(key: key);

  final List<Box> boxes;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: boxes.length,
      itemBuilder: (BuildContext context, int index) {
        return boxes[index];
      },
      onReorder: (int oldIndex, int newIndex) {
        print("$oldIndex   $newIndex");

        ///向下移会从0->2
        if (newIndex > oldIndex) {
          newIndex--;
        }
        var temp = boxes.removeAt(oldIndex);
        boxes.insert(newIndex, temp);
      },
    );
  }
}
