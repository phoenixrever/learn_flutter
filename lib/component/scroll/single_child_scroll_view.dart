import 'package:flutter/material.dart';

class SingleChildScrollViewDemo extends StatelessWidget {
  const SingleChildScrollViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SingleChildScrollView"),),
      ///有特殊情况需要滚动才用
      body: SingleChildScrollView(
        child: Column(
          children: [
            FlutterLogo(
              size: 500,
            ),
            FlutterLogo(
              size: 500,
            ),
            FlutterLogo(
              size: 500,
            ),
            FlutterLogo(
              size: 500,
            ),
          ],
        ),
      ),
    );
  }
}
