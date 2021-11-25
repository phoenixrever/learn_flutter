import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CountDownDemo extends StatefulWidget {
  @override
  _CountDownDemoState createState() => _CountDownDemoState();
}

class _CountDownDemoState extends State<CountDownDemo> {
  double zoom = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("count down button"),
      ),
      body: Transform.scale(
        scale: zoom,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CountDownButton(height:40,width:120,radius: 20),
              CountDownButton(height:120,width:120,radius: 60),
              CountDownButton(height:40,width:120,radius: 0),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            zoom == 1.0 ? zoom = 1.5 : zoom = 1.0;
          });
        },
        child: Icon(Icons.zoom_out),
      ),
    );
  }
}

class CountDownButton extends StatefulWidget {
  final double width;

  final double height;

  final double radius;

  CountDownButton({
    required this.width,
    required this.height,
    required this.radius,
  });

  @override
  _CountDownButtonState createState() => _CountDownButtonState();
}

class _CountDownButtonState extends State<CountDownButton>
    with SingleTickerProviderStateMixin {
  int _stage = 0;

  late String label;
  late Color textColor;
  late Color bgColor;

  late AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 5))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _stage = 2;
            });
          }
        });

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_stage) {
      case 0:
        label = "send";
        bgColor = Colors.white;
        textColor = Colors.blue;
        break;
      case 1:
        label = "Cancel";
        break;
      case 2:
        label = "Done";
        textColor = Colors.grey;
        break;
    }
    return Stack(
      children: [
        CustomPaint(
          painter: BorderPainter(
              buttonWidth: widget.width,
              buttonHeight: widget.height,
              buttonRadius: widget.radius,
              animation: _controller),
          child: SizedBox(
            width: widget.width,
            height:widget.height,
            child: TextButton(
              onPressed: () {
                if (_stage == 0) {
                  _controller.forward(from: 0.0);
                  setState(() {
                    _stage = 1;
                  });
                } else {
                  _controller.reset();
                  setState(() {
                    _stage = 0;
                  });
                }
              },
              child: Text(label),
              style: TextButton.styleFrom(
                  primary: textColor,
                  backgroundColor: bgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.radius))),
            ),
          ),
        ),
      ],
    );
  }
}

class BorderPainter extends CustomPainter {
  final double buttonWidth;
  final double buttonHeight;
  final double buttonRadius;
  final Animation<double> animation;

  final Paint bluePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..color = Colors.blue;

  final Paint greyPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..color = Colors.red;

  late RRect shape;
  late PathMetric pathMetric;

  BorderPainter({
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonRadius,
    required this.animation,

    /// CustomPainter({ Listenable? repaint }) 父类构造函数有能传入Listenable
    /// animation 继承 Listenable
  }) : super(repaint: animation) {
    shape = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset.zero,
          width: buttonWidth,
          height: buttonHeight,
        ),
        Radius.circular(buttonRadius));

    ///圆角矩形转化成路径
    final path = Path()..addRRect(shape);

    ///返回path的轮廓
    pathMetric = path.computeMetrics().single;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final totalLength = pathMetric.length;
    final currentLength = totalLength * animation.value;

    ///提取多少path长度 类似substring   Offset.zero不需要位移
    ///这样有个问题 起始点在不对
    // path.addPath(pathMetric.extractPath(0, currentLength), Offset.zero);

    ///起始点4分之1个length 正好在最上方
    ///max防止传入的radius过大
    final startingPoint =
        totalLength / 4 + max(buttonHeight / 2 - buttonRadius, 0);

    ///从0开始计算的length  从25开始 length 还要在家25才够一圈
    path.addPath(
        pathMetric.extractPath(startingPoint, currentLength + startingPoint),
        Offset.zero);
    path.addPath(
        pathMetric.extractPath(
            0.0, currentLength + startingPoint - totalLength),
        Offset.zero);
    canvas.translate(buttonWidth / 2, buttonHeight / 2);

    canvas.drawRRect(shape, bluePaint);
    canvas.drawPath(path, greyPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
