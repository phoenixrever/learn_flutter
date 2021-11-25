import 'package:flutter/material.dart';

import 'flip_counter.dart';

class CounterPlugin extends StatefulWidget {
  const CounterPlugin({
    Key? key,
  }) : super(key: key);

  @override
  _CounterPluginState createState() => _CounterPluginState();
}

class _CounterPluginState extends State<CounterPlugin> {
  double _value=2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          width: 200,
          child: AnimatedFlipCounter(
            duration: Duration(milliseconds: 500),
            value: _value,
              prefix: "Level ",
              textStyle: TextStyle(
                fontSize:60,
                fontWeight: FontWeight.bold,
                letterSpacing: -8.0,
                color: Colors.yellow,
                shadows: [
                  BoxShadow(
                    color: Colors.orange,
                    offset: Offset(8, 8),
                    blurRadius: 8,
                  ),
                ],
              ),
          ),
        ),
        TextButton(onPressed: (){setState(() {
          _value++;
        });}, child: Text("start")),
        TextButton(onPressed: (){setState(() {
          _value=0;
        });}, child: Text("start")),
      ],
    );
  }
}

