import 'package:flutter/material.dart';

class WillPopScopeDemo extends StatefulWidget {
  @override
  _WillPopScopeDemoState createState() => _WillPopScopeDemoState();
}

class _WillPopScopeDemoState extends State<WillPopScopeDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WillPopScopeDemo'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(),
                  ));
            },
            child: Text("WillPopScopeDemo"),
          ),
        ));
  }
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _lock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WillPopScopeDemo"),
      ),
      body: WillPopScope(
        // onWillPop: () async {
        //   var dialog = await showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text("确定要返回吗"),
        //         content: Text("你有未保存的内容"),
        //         actions: [
        //           ElevatedButton(
        //             onPressed: () {
        //               Navigator.pop(context, false);
        //             },
        //             child: Text("cancel"),
        //           ),
        //           ElevatedButton(
        //             onPressed: () {
        //               Navigator.pop(context, true);
        //             },
        //             child: Text("確認"),
        //           ),
        //         ],
        //       );
        //     },
        //   );
        // },

        ///有错误
        onWillPop: _lock ? () async => false:null,
        child: Center(
          child: Transform.scale(
            scale: 3.0,
            child: IconButton(
              icon: _lock == false ? Icon(Icons.lock_open) : Icon(Icons.lock),
              onPressed: () {
                setState(() {
                  _lock = !_lock;
                });

                ///与ios滑动退出手势冲突    WillPopScope 自动调用这2个函数
                // if (_lock) {
                //   ModalRoute.of(context)!.addScopedWillPopCallback(preventExit);
                // }else{
                //   ModalRoute.of(context)!.removeScopedWillPopCallback(preventExit);
                // }
              },
            ),
          ),
        ),
      ),
    );
  }
// Future<bool> preventExit() async =>false;
}
