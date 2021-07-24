import 'dart:ffi';

import 'package:flutter/material.dart';

class InheritedWidgetDemo extends StatefulWidget {

  @override
  _InheritedWidgetDemoState createState() => _InheritedWidgetDemoState();
}

class _InheritedWidgetDemoState extends State<InheritedWidgetDemo> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return CountProvider(
      count: _count,
      addCount: () =>
      {
        setState(() {
          _count++;
        })
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("provider"),
        ),
        body: ChipWrapper(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
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

class CountProvider extends InheritedWidget {
  final int count;
  final VoidCallback addCount;
  final Widget child;

  CountProvider(
      {required this.count, required this.addCount, required this.child})
      : super(child: child);

  static CountProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CountProvider>();


  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class ChipWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SonChip(),
        SonChip(),
        SonChip(),
      ],
    );
  }
}

class SonChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int count = CountProvider.of(context)!.count;
    final VoidCallback add = CountProvider.of(context)!.addCount;
    return ActionChip(label: Text("$count"), onPressed: () => add());
  }
}
