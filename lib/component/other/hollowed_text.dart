import 'dart:math';

import 'package:flutter/material.dart';

class HollowedText extends StatelessWidget {
  HollowedText({Key? key}) : super(key: key);
  final text = "ssss";
  final Color _color = Colors.red;
  final double _fontSize = 50;
  final double _strokeWidth = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hollowed Text"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            // color: Colors.blue,
            child: MyHollowedText(text: text, fontSize: _fontSize, strokeWidth: _strokeWidth,color: _color,),
          ),
          Text("hello",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,

                  ///shadow 消耗性能
                  // shadows: [
                  //   Shadow(color: Colors.red, offset: Offset(0, 2)),
                  //   Shadow(color: Colors.red, offset: Offset(2, 0)),
                  //   Shadow(color: Colors.red, offset: Offset(-2, 0)),
                  //   Shadow(color: Colors.red, offset: Offset(0, -2)),
                  //   Shadow(color: Colors.red, offset: Offset(2, -2)),
                  //   Shadow(color: Colors.red, offset: Offset(2, -2)),
                  //   Shadow(color: Colors.red, offset: Offset(-2, -2)),
                  //   Shadow(color: Colors.red, offset: Offset(2, 2)),
                  //   Shadow(color: Colors.red, offset: Offset(-2, 2)),
                  // ]),
                  shadows: List.generate(
                      8,
                      (index) => Shadow(
                          color: Colors.red,
                          offset: Offset.fromDirection(pi / 4 * index))))),
          Stack(
            children: [
              Text("你好",style: TextStyle(fontSize: 50,fontWeight: FontWeight.w900,color: Colors.red),),
              Text("你好",style: TextStyle(fontSize: 50,fontWeight: FontWeight.w100,color: Colors.white),)
            ],
          )
        ],
      ),
    );
  }
}

class MyHollowedText extends StatelessWidget {
  const MyHollowedText({
    Key? key,
    required this.text,
    double? fontSize,
    double? strokeWidth,
    Color? color,
  }) : _fontSize = fontSize??20, _strokeWidth = strokeWidth??2, _color=color??Colors.white,super(key: key);

  final String text;
  final double _fontSize;
  final Color _color;
  final double _strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child: Text(
          text,
          style: TextStyle(
              fontSize: _fontSize,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..color = _color
                ..strokeWidth = _strokeWidth),
        )),
      ],
    );
  }
}
