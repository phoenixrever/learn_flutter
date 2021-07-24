import 'package:flutter/material.dart';

class ValueNotifierDemo extends StatefulWidget {
  @override
  _ValueNotifierDemoState createState() => _ValueNotifierDemoState();
}

class _ValueNotifierDemoState extends State<ValueNotifierDemo> {

  int number = 0;

  // 创建一个监听实例,在需要监听这个改变的地方使用ValueListenableBuilder去包裹你的Widget
  ValueNotifier<int> numberNotifier = new ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    numberNotifier.value = number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: numberNotifier,
            builder: (context, value, child) {
              return Center(
                child: Text("numberNotifier 当前的数字:$value"),);
            },
          ),
          Center(
            child: Text("当前的数字:$number"),)
            ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Text("+", style: TextStyle(fontSize: 20),),
        onPressed: () {
          // 数字改变
          number ++;
          // number 改变时候 只刷新监听了numberNotifier的界面
          numberNotifier.value = number;
        },
      ),
    );
  }
}
