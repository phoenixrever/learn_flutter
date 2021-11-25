import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class KeyDemo extends StatefulWidget {
  const KeyDemo({Key? key}) : super(key: key);

  @override
  _KeyDemoState createState() => _KeyDemoState();
}

class _KeyDemoState extends State<KeyDemo> {
  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text("key demo"),
        centerTitle: true,
      ),
      body:
          // orientation==Orientation.portrait? Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Counter(
          //       key: _globalKey,
          //     ),
          //     Counter(),
          //   ],
          // ):Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Counter(
          //       key: _globalKey,
          //     ),
          //     Counter(),
          //   ],
          // ),
          //flex没有变 他的子元素的状态也没有丢失 不需要key
          Flex(
        direction: orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
        children: [
          Counter(),
          Counter(),
          Counter(key: _globalKey),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.primaries[0],
        child: Icon(Icons.add),
        onPressed: () {
          // 类型转换 明确是Counter的state(应为有可能是_globalKey会传给Flex ??? 不太懂)
          var currentState = (_globalKey.currentState as _CounterState);
          var currentWidget = (_globalKey.currentWidget as Counter);
          ///获得组件的属性 如size 和offset
          var renderBox = (_globalKey.currentContext!.findRenderObject() as RenderBox);
          var currentContext = _globalKey.currentContext;

          print(currentContext!.size);//Size(360.0, 48.0)
          print(renderBox.size);//Size(360.0, 48.0)
          print(renderBox.localToGlobal(Offset.zero));

          currentState.setState(() {
            currentState._count++;
          });
        },
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({
    Key? key,
  }) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(Size(100, 100)),
        child: ActionChip(
          label: Text(
            "$_count",
            style: TextStyle(fontSize: 30),
          ),
          onPressed: () {
            setState(() {
              _count++;
            });
          },
        ),
      ),
    );
  }
}
