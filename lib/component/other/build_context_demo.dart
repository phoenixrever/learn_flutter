import 'package:flutter/material.dart';

class BuildContextDemo extends StatelessWidget {
  const BuildContextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BuildContext"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(
                text:
                    "同在一个组件下 Scaffold.of(context).openDrawer() 是无法打开本组件的draw的 of(context) Scaffold  想要打开就必须把 floatbuton 做成子组件 就会找到父级的Scaffold  也就是Draw所在的Scaffold  或者LayoutBuilder  里面有新的context"),
          ),
        )),
      ),
      floatingActionButton: LayoutBuilder(
        builder: (BuildContext context2, BoxConstraints constraints) {
          return FloatingActionButton(
            onPressed: () {
              Scaffold.of(context2).openDrawer();
            },
            child: Icon(Icons.add),
          );
        },
      ),
      drawer: Drawer(),
    );
  }
}

///第一种方法 直接拆分出去
class SubWidget extends StatelessWidget {
  const SubWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
