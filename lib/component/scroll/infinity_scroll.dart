import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class InfinityScroll extends StatefulWidget {
  const InfinityScroll({Key? key}) : super(key: key);

  @override
  _InfinityScrollState createState() => _InfinityScrollState();
}

class _InfinityScrollState extends State<InfinityScroll> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("change notifier"),),
      body: ChangeNotifierProvider(
        create: (context) => ListModel(),
        child: ScollList(),
      ),
    );
  }
}

class ListModel extends ChangeNotifier {

  List<int> temp = [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30];
  List<int> array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  List<String> _items = [];

  List<String> get items => _items;

  static const int ItemRequestThreshold = 10;

  int _currentPage = 0;

  ListModel() {
    _items = List.generate(15, (index) => "$index");
  }

  Future handleItemCreated(int index) async {
    var itemPosition = index + 1;
    var requestMoreData =
        itemPosition % ItemRequestThreshold == 0 && itemPosition != 0;
    print(requestMoreData);
    var pageToRequest = itemPosition ~/ ItemRequestThreshold;
    //上滚不需要加载数据
    if (requestMoreData && pageToRequest > _currentPage) {
      _currentPage = pageToRequest;
      // TODO: Show loading indicator, Request more data and hide loading indicator
      await Future.delayed(Duration(seconds: 1));
      var newFetchedItems = List<String>.generate(
          15, (index) => 'Title page:$_currentPage item: $index');
      _items.addAll(newFetchedItems);
      notifyListeners();
    }
  }
}

class ScollList extends StatefulWidget {
  const ScollList({Key? key}) : super(key: key);

  @override
  State<ScollList> createState() => _ScollListState();
}

class _ScollListState extends State<ScollList> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ListModel>(
      //context   第二个参数是 ChangeNotifier 的实例
      builder: (context, value, child) {
        print(value);
        return ListView.builder(itemBuilder: (BuildContext context, int index) {
          print(index + 1);
          // 如果有 setState() or markNeedsBuild() called during build 就加上
          // SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {  value.handleItemCreated(index);});
          value.handleItemCreated(index);
          return Container(
            height: 100,
            width: double.infinity,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            child: Text(value.items[index].toString()),
          );
        }, itemCount: value.items.length,);
      },
    );
  }
}

// class SonChip extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // final int count = CountProvider.of(context)!.count;
//     // final VoidCallback add = CountProvider.of(context)!.addCount;
//     return Consumer<ListModel>(
//       //context   第二个参数是 ChangeNotifier 的实例
//       builder: (context, value, child) {
//         return Column(
//           children: [
//             ActionChip(label: Text("${value.count}"), onPressed: () =>value.add()),
//             ActionChip(label: Text("${value.count}"), onPressed: () =>value.minus()),
//           ],
//         );
//       },
//     );
//   }
// }

// class Clear extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     final countModel = Provider.of<CountModel>(context);
//     return ElevatedButton(onPressed: (){countModel.remove();}, child: Text("clear"));
//   }
// }
