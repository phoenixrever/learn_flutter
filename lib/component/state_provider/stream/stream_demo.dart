import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_flutter/component/title_divider.dart';
import 'package:learn_flutter/network/http_request.dart';

class StreamDemo extends StatefulWidget {
  const StreamDemo({Key? key}) : super(key: key);

  @override
  _StreamDemoState createState() => _StreamDemoState();
}

class _StreamDemoState extends State<StreamDemo> {
  late StreamSubscription _streamSubscription;
  late StreamSubscription _streamSubscriptionBroadcast;
  late StreamController<String> _streamController;
  late StreamSink _streamSink;
  List<dynamic> items = [];

  Future<String> fetchData() async {
    final result = await HttpRequest.request(
        "https://api.github.com/search/users",
        http_method: "get",
        params: {"q": "phoenix"});
    // print(result.data.runtimeType);
    return json.encode(result.data);
  }

  void onData(data) {
    ///streambuilder 不需要手动构建widget 但是必须要初始值 不用
    print("-----------" + data);
    var decode = json.decode(data);
    setState(() {
      items = decode["items"];
    });
  }

  void onDataBroadcast(data) {
    // print("BroadcastData--------------------?$data");
  }

  onError(error) {
    print("Error-----------:$error");
  }

  void onDone() {
    print("done--------");
  }

  void addDataToStream() async {
    String result = await fetchData();
    // _streamController.add(result);
    //sink方法
    _streamSink.add(result);
  }

  @override
  void initState() {
    super.initState();
    // Stream<String> _streamDemo = Stream.fromFuture(fetchData());
    // _streamSubscription = _streamDemo.listen(onData, onError: onError, onDone: onDone);

    ///单订阅流(Single Subscription),这种流最多只能有一个监听器(listener)
    // _streamController = StreamController<String>();
    //_streamSubscription= _streamController.stream.listen(onBData, onError: onError, onDone: onDone);

    ///多订阅流(Broadcast),这种流可以有多个监听器监听（listener）
    _streamController = StreamController.broadcast();
    _streamSubscription = _streamController.stream
        .listen(onData, onError: onError, onDone: onDone);
    _streamSubscriptionBroadcast = _streamController.stream
        .listen(onDataBroadcast, onError: onError, onDone: onDone);

    //sink为getter 方法  StreamSink<String> get sink
    _streamSink = _streamController.sink;
  }

  //controller  好像都要关闭
  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("stream")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TitleDivider(title: "steam 暂停 恢复订阅"),
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        openSnackBar(context, "Pause");
                        _streamSubscription.pause();
                      },
                      child: Text("Pause")),
                  ElevatedButton(
                      onPressed: () {
                        openSnackBar(context, "Resume");
                        _streamSubscription.resume();
                      },
                      child: Text("Resume")),
                  ElevatedButton(
                      onPressed: () {
                        openSnackBar(context, "Cancel");
                        _streamSubscription.cancel();
                      },
                      child: Text("Cancel")),
                ],
              ),
              TitleDivider(title: "StreamController"),
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        openSnackBar(context, "Add");
                        addDataToStream();
                      },
                      child: Text("Add ")),
                ],
              ),
              TitleDivider(title: "users"),
              ...List.generate(
                  items.length,
                  (index) => Card(
                        child: Column(
                          children: [
                            ListTile(
                              title:Text( items[index]["login"]),
                              leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(items[index]["avatar_url"],)),
                            )
                          ],
                        ),
                      ))


              ///这样不好 这个必须要初始值
              // StreamBuilder(
              //   initialData: {items:[{"sss","sss"}]},
              //     stream: _streamController.stream,
              //     builder: (context, snapshot) {
              //       print(snapshot.data);
              //       List<dynamic> items = json.decode(
              //           (snapshot.data).toString())["items"];
              //       print(items);
              //       return Column(
              //           children: [
              //             ...List.generate(
              //                 items.length,
              //                     (index) =>
              //                     Card(
              //                       child: Column(
              //                         children: [
              //                           ListTile(
              //                             title: Text(items[index]["login"]),
              //                             leading: CircleAvatar(
              //                                 backgroundImage:
              //                                 NetworkImage(
              //                                   items[index]["avatar_url"],)),
              //                           )
              //                         ],
              //                       ),
              //                     ))
              //           ]
              //       );
              //     }
              // )
            ],
          ),
        ),
      ),
    );
  }

  void openSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 500),
        action: SnackBarAction(
          label: "action",
          onPressed: () {},
        ),
        content: Container(
          child: Text("$text"),
        )));
  }
}
