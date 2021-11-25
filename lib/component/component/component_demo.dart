import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn_flutter/Component/title_divider.dart';
import 'package:learn_flutter/component/component/route_pass_value.dart';
import 'dart:async';
import '../button/checkbox_radio.dart';
import '../button/common_button.dart';
import '../button/pop_menu_button.dart';
import 'chips.dart';
import 'dialog_demo.dart';
import 'others.dart';

class ComponentDemo extends StatefulWidget {
  const ComponentDemo({Key? key}) : super(key: key);

  @override
  _ComponentDemoState createState() => _ComponentDemoState();
}

class _ComponentDemoState extends State<ComponentDemo> {
  int _selectedIndex = 0;
  final bottomSheetScaffoldKey = GlobalKey<ScaffoldState>();
  final childKey = GlobalKey<ChipsDemoState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: bottomSheetScaffoldKey,
      appBar: AppBar(
        title: Text("ComponentDemo"),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('button'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.book),
                label: Text('popmenu'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.star_border),
                selectedIcon: Icon(Icons.star),
                label: Text('checkbox'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_alert_outlined),
                selectedIcon: Icon(Icons.add_alert),
                label: Text('dialog'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.announcement_outlined),
                selectedIcon: Icon(Icons.announcement),
                label: Text('chips'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings_applications),
                label: Text('others'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings_applications),
                label: Text('route'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  CommonButton(),
                  PopMenu(),
                  CheckBoxRadio(),
                  DialogDemo(),
                  ChipsDemo(
                    key: childKey,
                  ),
                  Others(),
                  RoutePassValue()
                ],
              ),
            ),
          )
        ],
      ),
      // persistentFooterButtons: [
      //   IconButton(onPressed: (){}, icon: Icon(Icons.save)),
      //   IconButton(onPressed: (){}, icon: Icon(Icons.expand))
      // ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          childKey.currentState!.initTags();
        },
        child: Icon(Icons.add),
        // shape: BeveledRectangleBorder(
        //   borderRadius: BorderRadius.circular(30)
        // ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
        ),
      ),
    );
  }
}

