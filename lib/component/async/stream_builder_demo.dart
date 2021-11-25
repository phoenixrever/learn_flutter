import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilderDemo extends StatefulWidget {
  const StreamBuilderDemo({Key? key}) : super(key: key);

  @override
  _StreamBuilderDemoState createState() => _StreamBuilderDemoState();
}

class _StreamBuilderDemoState extends State<StreamBuilderDemo> {
  int _count = 0;

  // final future = Future.delayed(Duration(seconds: 1), () => 100);
  // final stream = Stream.periodic(Duration(seconds: 2), (value) => 1000);

  /// sink是水池 水的源头 建立一个stream 就会提供一个水源(水池或者水龙头) 和水流
  // final _streamController =  StreamController();

  ///广播 同时被多人监听
  /// 广播不会保存数据  二普通的会  事件会保留到  event queue
  /// 举例 延迟5秒期间按键添加时间 5秒到后都会执行  而broadcast不会
  final _streamController = StreamController.broadcast();

  @override
  void initState() {
    /*
    ///水源增加事件
    _streamController.sink.add(999);

    ///监听水流(事件)
    _streamController.stream.listen((event) {print(event);});
    
    future.then((value) => print("future $value"));

    // stream.listen((event) {
    //   print("stream $event");
    // });
    */

    _streamController.stream.listen((event) {
      print("broadcast $event");
    });

    ///stream 语法糖
    // getDateTime().listen((event) {print(event);});
    super.initState();
  }


  Stream<DateTime> getDateTime() async*{
    while(true){
      await Future.delayed(Duration(seconds: 1));
      yield DateTime.now();
    }
  }
  
  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.headline4!,
            child: StreamBuilder(
              stream: _streamController.stream
                  .where((event) => event is int)
                  .map((event) => event * 2)
              ///如果build的event 一样  不build
                  .distinct(),
              initialData: 55,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                print(snapshot.data);
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text("none  没有数据流");
                    break;
                  case ConnectionState.waiting:
                    return Text("等待数据流");
                    break;
                  case ConnectionState.active:
                    if (snapshot.hasError) {
                      return Text("error  ${snapshot.error}");
                    } else {
                      return Text("active  ${snapshot.data}");
                    }
                    break;
                  case ConnectionState.done:
                    return Text("done 数据流关闭");
                    break;
                }
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _streamController.sink.add(72);
              },
              child: Text("add event 72")),
          ElevatedButton(
              onPressed: () {
                _streamController.sink.add(10);
              },
              child: Text("add event 10")),
          ElevatedButton(
              onPressed: () {
                _streamController.sink.addError("oops error");
              },
              child: Text("add event error")),
          ElevatedButton(
              onPressed: () {
                _streamController.sink.add("hello");
              },
              child: Text("add event hello")),
          ElevatedButton(
              onPressed: () {
                _streamController.close();
              },
              child: Text("close stream")),
        ],
      ),
    );
  }
}
