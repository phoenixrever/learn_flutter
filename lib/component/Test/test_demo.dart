import 'package:flutter/material.dart';

class TestDemo extends StatelessWidget {
  const TestDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unit Text"),
        centerTitle: true,
      ),
      body: TestWidgetDemo(),
    );
  }
}

class TestWidgetDemo extends StatefulWidget {
  @override
  _TestWidgetDemoState createState() => _TestWidgetDemoState();
}

class _TestWidgetDemoState extends State<TestWidgetDemo> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(label: Text("hello")),
        ActionChip(
            key: Key("actionChipTest"),
            label: Text("$_count",key:Key("actionChipLabelTest")),
            onPressed: () {
              setState(() {
                _count++;
              });
            })
      ],
    );
  }
}

class ClassTestDemo {
  static greet(String name) {
    return "hello $name";
  }
}
