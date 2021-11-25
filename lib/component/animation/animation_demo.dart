import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:learn_flutter/component/animation/counter_puigin.dart';
import 'package:learn_flutter/component/animation/multi_animation.dart';
import 'package:learn_flutter/component/animation/tween_transform.dart';

import 'animated_counter.dart';
import 'animated_widget.dart';
import 'circle_animation.dart';
import 'controller_dmo.dart';
import 'custom_animation.dart';
import 'custom_painter.dart';
import 'flip_counter.dart';
import 'heart_animation.dart';
import 'hero_animation.dart';

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({Key? key}) : super(key: key);

  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

//with混合
class _AnimationDemoState extends State<AnimationDemo> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("animation"),
      ),
      body: Row(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    selectedIndex: _selectedIndex,
                    labelType: NavigationRailLabelType.all,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite_border),
                        selectedIcon: Icon(Icons.favorite),
                        label: Text('animation'),
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
                      NavigationRailDestination(
                        icon: Icon(Icons.circle_notifications_outlined),
                        selectedIcon: Icon(Icons.circle_notifications),
                        label: Text('transform'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.circle_notifications_outlined),
                        selectedIcon: Icon(Icons.circle_notifications),
                        label: Text('counter'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.circle_notifications_outlined),
                        selectedIcon: Icon(Icons.circle_notifications),
                        label: Text('contoller'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.circle_notifications_outlined),
                        selectedIcon: Icon(Icons.circle_notifications),
                        label: Text('multi'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.circle_notifications_outlined),
                        selectedIcon: Icon(Icons.circle_notifications),
                        label: Text('custom'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.circle_notifications_outlined),
                        selectedIcon: Icon(Icons.circle_notifications),
                        label: Text('painer'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          VerticalDivider(
            width: 1,
            color: Colors.grey,
          ),
          Expanded(
              child: IndexedStack(
            index: _selectedIndex,
            children: [
              HeartAnimation(),
              HeroAnimationDemo(),
              CircleAnimationDemo(),
              AnimatedWidgetDemo(),
              TweenTransform(),
              AnimatedCounter(),
              ControllerDemo(),
              MultiAnimation(),
              CustomAnimation(),
              CustomPainterDemo(),
            ],
          ))
        ],
      ),
    );
  }
}
