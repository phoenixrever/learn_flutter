import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterDemo extends StatefulWidget {
  const CustomPainterDemo({Key? key}) : super(key: key);

  @override
  _CustomPainterDemoState createState() => _CustomPainterDemoState();
}

class _CustomPainterDemoState extends State<CustomPainterDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Snowflake>  list = List.generate(500, (index) => Snowflake());

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _controller.repeat();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent,Colors.lightBlue.withOpacity(0.5), Colors.white],
            stops:[0.0, 0.6,0.95],
          )),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          list.forEach((element) {
            element.fall();
          });
          return CustomPaint(painter: MyPainter(list: list));
        },
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Snowflake> list;

  MyPainter({required this.list});

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawCircle(Offset(size.width/2, size.height/2), 20.0, Paint());
    //center 是相对位移
    final whitePaint = Paint()
      ..color = Colors.white;
    canvas.drawCircle(size.center(Offset(0, 100)), 60.0, whitePaint);
    canvas.drawOval(
        Rect.fromCenter(
            center: size.center(Offset(0, 250)), width: 200, height: 250),
        whitePaint);
    // list.forEach((element) {
    //   canvas.drawCircle(Offset(element.x,element.y),
    //       element.radius, whitePaint);
    // });
    List.generate(
        list.length,
            (index) =>
            canvas.drawCircle(Offset(list[index].x, list[index].y),
                list[index].radius, whitePaint));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Snowflake {
  double x = Random().nextDouble() * 400,
      y = Random().nextDouble() * 1000;
  double radius = Random().nextDouble() * 3 + 2;
  double speed = Random().nextDouble() * 3 + 2;

  fall() {
    y += speed;
    if (y > 1000) {
      y = 0;
      x = Random().nextDouble() * 400;
      radius = Random().nextDouble() * 3 + 2;
      speed = Random().nextDouble() * 3 + 2;
    }
  }
}
