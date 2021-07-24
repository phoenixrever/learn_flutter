import 'dart:async';

import 'package:flutter/material.dart';

/// 不理解 跑不通 怀疑讲错的
/// 以后再看
class BlocDemo extends StatelessWidget {
  const BlocDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      bloc: CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title:Text("bloc")
        ),
        body: ChipComponent(),
        floatingActionButton: CounterComponent(),
      ),
    );
  }
}

class CounterComponent extends StatelessWidget {
  const CounterComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CounterBloc _counterBloc = CounterProvider.of(context)!.bloc;
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        _counterBloc._counterController.add(1);
      },
    );
  }
}

class ChipComponent extends StatelessWidget {
  const ChipComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CounterBloc _counterBloc = CounterProvider.of(context)!.bloc;
    return Center(
      child: StreamBuilder(
        initialData: 0,
        stream: _counterBloc.counterStream,
        builder: (context, snapshot) {
          return ActionChip(
            label: Text("${snapshot.data}"),
            onPressed: () {
              // _counterBloc.counterSink.add(1);
              _counterBloc.counterSink.add(1);
            },
          );
        },

      ),
    );
  }
}

class CounterProvider extends InheritedWidget {
  final Widget child;
  final CounterBloc bloc;

  CounterProvider({required this.child, required this.bloc})
      : super(child: child);

  static CounterProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CounterProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class CounterBloc {
  int _count = 0;
  ///前面int不能省 不然就是dynamic 后面能省
  final StreamController<int> _counterActionController = StreamController<int>();
   StreamSink<int> get counterSink => _counterActionController.sink;

  final StreamController<int> _counterController = StreamController<int>();
  Stream<int> get counterStream => _counterController.stream;

  CounterBloc(){
    print("xxxxxxxxxxxx");
    _counterActionController.stream.listen(onData);
  }

  void dispose(){
    _counterController.close();
    _counterActionController.close();
  }

  // 这边可以声明类型
  void  onData (int data){
    print("$data");
    _count=data+_count;
    //注意 不是steam.add
    _counterController.add(_count);
  }

  void log() {
    print("log");
  }
}
