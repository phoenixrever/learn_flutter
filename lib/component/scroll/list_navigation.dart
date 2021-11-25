import 'package:flutter/material.dart';
import 'package:learn_flutter/component/async/stream_builder_demo.dart';
import 'package:learn_flutter/component/layout/vertical_list_bar.dart';

class ListNavigation extends StatefulWidget {
  const ListNavigation({Key? key}) : super(key: key);

  @override
  _ListNavigationState createState() => _ListNavigationState();
}

class _ListNavigationState extends State<ListNavigation> {
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("list navigation"),
      ),
      body: Row(
        children: [
          VerticalListBar(
              count: 3,
              onSelected: (int index) {
               setState(() {
                 _selectedIndex=index;
               });
              },
              children: [
                Center(child: Text("StreamBuilder")),
                Center(child: Text("StreamBuilder")),
                Center(child: Text("StreamBuilder")),
              ]),
          VerticalDivider(width: 1,),
          Expanded(
            child:IndexedStack(
              index: _selectedIndex,
              children: [
                StreamBuilderDemo(),
                Text("2"),
                Text("3"),
              ],
            )
          )
        ],
      ),
    );
  }
}
