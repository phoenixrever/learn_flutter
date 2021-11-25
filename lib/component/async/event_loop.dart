import 'dart:async';

import 'package:flutter/material.dart';

class EventLoop extends StatelessWidget {
  const EventLoop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Future.sync
    /// Future.value.then  microtask
    /// Future.microtask
    /// scheduleMicrotask queue
    /// delayed zero
    /// no delay
    /// Future.then  event queue

    ///立即执行 string 包装成Future<String>对象
    Future.value("Future<String>");

    ///已经完成的future 也会进入microtask
    Future.value().then((value) => print(" Future.value.then  microtask"));

    Future.microtask(() => print("Future.microtask"));
    scheduleMicrotask(() => print("scheduleMicrotask queue"));

    Future.sync(() => print("Future.sync"));

    ///duration并不是精确能运行的时间二是加到event loop的时间
    Future.delayed(Duration.zero).then((value) => print("delayed zero"));

    Future(() => print("no delay"))
        .then((value) => print(" Future.then  event queue"));

    /// event 1
    /// event 2
    /// event 3
    /// add microtask queue

    ///then 会立即执行 不会加入microtask
    Future.delayed(Duration(seconds: 1))
        .then((value) => print("event 1"))
        .then((value) {
      scheduleMicrotask(() => print("add microtask queue"));
      print("event 2");
    }).then((value) => print("event 3"));

    Future(() => print("boring"))
        .then((value) => Future.error(Exception("my error")))
        .then((value) => print("1s after"))
        .catchError((error) => print(error))
        .whenComplete(() => print("java finally"));

    ///100
    Future.value(100).then((value) => print(value));

    ///2000
    Future.value(1000).then((value) =>value*2).then((value) => print(value));

    // throw "oops";

    return Column(
      children: [
        OutlinedButton(
            onPressed: () {
              ///等待1秒推送到event queue
              Future.delayed(Duration(seconds: 1))
                  .then((value) => buildShowDialog(context));
              Future.delayed(Duration(seconds: 1), () {
                buildShowDialog(context);
              });
            },
            child: Text("delayed 1s"))
      ],
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("delay 1 seconds"),
          content: Text("delay 1 seconds"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("确认"))
          ],
        );
      },
    );
  }
}
