import 'package:flutter/material.dart';
import 'package:learn_flutter/component/async/future_builder.dart';

import 'event_loop.dart';

class FutureDemo extends StatefulWidget {
  const FutureDemo({Key? key}) : super(key: key);

  @override
  _FutureDemoState createState() => _FutureDemoState();
}

class _FutureDemoState extends State<FutureDemo> {
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("future"),centerTitle: true,),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (value) {
              print(value);
            setState(() {
              _selectedIndex=value;
            });
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('future'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.book),
                label: Text('hero'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.circle_notifications_outlined),
                selectedIcon: Icon(Icons.circle_notifications),
                label: Text('circle'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.circle_notifications_outlined),
                selectedIcon: Icon(Icons.circle_notifications),
                label: Text('widget'),
              ),
            ],
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                EventLoop(),
              FutureBuilderDemo(),
                Container(child: Text("$_selectedIndex"),),
                Container(child: Text("$_selectedIndex"),),

              ],
            ),
          )
        ],
      ),
    );
  }
}

