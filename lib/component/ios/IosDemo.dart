import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';

class IosDemo extends StatelessWidget {
  const IosDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget dialog;
    if (Platform.isAndroid) {
      dialog = CupertinoDemo();
    } else if (Platform.isIOS) {}
    return CupertinoApp(
      title: "ios app",
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("标题"),
          trailing: Icon(Icons.more_horiz),
          backgroundColor: Color(0xfff1f1f1),
          leading: Icon(CupertinoIcons.back),
          // previousPageTitle: "返回",
          automaticallyImplyLeading: true,
          automaticallyImplyMiddle: true,
        ),
        child: Column(
          children: [
            Text("ios"),
            dialog,
          ],
        ),
      ),
    );
  }
}

class CupertinoDemo extends StatelessWidget {
  const CupertinoDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("ios alert"),
      content: Text("Platform.isAndroid 判断平台"),
      actions: [TextButton(onPressed: () {}, child: Text("确认"))],
    );
  }
}
