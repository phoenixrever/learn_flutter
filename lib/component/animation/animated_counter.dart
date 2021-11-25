import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_flutter/component/title_divider.dart';

import 'counter_puigin.dart';

class AnimatedCounter extends StatefulWidget {
  @override
  _AnimatedCounterState createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> {
  double _count = 2014;
  List<double> nums = [];
  double value = 0;

  getNumber() {
    List<double> temp = [];
    value = _count;
    while (value > 0) {
      temp.add(value);
      value = (value ~/ 10).toDouble();
    }
    // temp=temp.reversed.toList(growable: false);
    print("$temp temp-----------");
    return temp;
  }

  @override
  void initState() {
    super.initState();
    value=_count;
    nums = getNumber();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 200,
            height: 60,
            color: Colors.limeAccent,
            child: Row(
              children: [
                Stack(
                  children: [
                    ...List.generate(nums.length, (index) {
                      return NumberCount(count: nums[index],textStyle: TextStyle(fontSize: 50),);})
                  ]
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 20,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _count = _count + 1;
                      nums = getNumber();
                    });
                  },
                  child: Text("start")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      if (_count > 0) {
                        _count = _count - 1;
                        nums = getNumber();
                      }
                    });
                  },
                  child: Text("reset")),
            ],
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text("1 显示数字转成数组 [23.0, 2.0] 转成整数 计算个数得出宽度"),
                ),
                ListTile(
                  title: Text("2 背景色盖住其他数组的宽度 最长的下最下面"),
                ),
              ],
            ),

          ),
          TitleDivider(title: "counter plugin"),
          CounterPlugin(),
        ],
      ),
    );
  }
}

class NumberCount extends StatelessWidget {
  final double count;
  final Duration duration;
  final TextStyle textStyle;

  NumberCount(
      {required this.count, this.duration = const Duration(milliseconds: 500), required this.textStyle,});

  @override
  Widget build(BuildContext context) {
    print('${count.toInt().toString().length} --count--');
    final style = DefaultTextStyle.of(context).style.merge(textStyle);
    final prototypeDigit = TextPainter(
      text: TextSpan(text: "8", style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
    )..layout();
    print('${prototypeDigit.size.width}');
    return TweenAnimationBuilder(
      duration: duration,
      tween: Tween<double>(end: count),

      ///builder里面所有控件都是动画控件
      builder: (BuildContext context, double value, Widget? child) {
        final num = value ~/ 1;
        final decimal = value - num;
        return Container(
          width: count.toInt().toString().length*prototypeDigit.width,
          height: 80,

          decoration: BoxDecoration(
            border: Border.all(width: 2,color:Color.fromRGBO(Random().nextInt(256),Random().nextInt(256),Random().nextInt(256),1))
                ,color: Colors.white
          ),
          padding: EdgeInsets.only(right: 00),
          alignment: Alignment.centerRight,
          child: Stack(
            children: [
              Positioned(
                  top: -50 * decimal,
                  child: Opacity(
                    opacity: 1 - decimal,
                    child: Text(
                      "$num",
                      textAlign: TextAlign.right,
                      style: textStyle
                    ),
                  )),
              Positioned(
                top: 50 - decimal * 50,
                child: Opacity(
                  opacity: decimal,
                  child: Text(
                    "${num + 1}",
                    style: textStyle
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
