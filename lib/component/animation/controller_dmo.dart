import 'package:flutter/material.dart';

class ControllerDemo extends StatefulWidget {
  const ControllerDemo({Key? key}) : super(key: key);

  @override
  _ControllerDemoState createState() => _ControllerDemoState();
}

class _ControllerDemoState extends State<ControllerDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    /// ..  可以回传函数的本身作为返回值
    // _controller = AnimationController(vsync: this,duration: Duration(seconds: 1))..repeat();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Wrap(
          spacing: 20,
          children: [
            ...List.generate(5, (index) => SlideTransition(
              // position: _controller.drive(Tween<Offset>(begin: Offset(0, 0),end: Offset(0,15))),
              position: Tween<Offset>(begin: Offset(0, 0),end: Offset(0,15))
                  .chain(CurveTween(curve: Curves.bounceOut))
                  ///后一半时间才动画
                  .chain(CurveTween(curve: Interval(0.5,1)))
                  .animate(_controller),
              child: RotationTransition(
                turns: _controller,
                child: Text(
                  "卍",
                  style: TextStyle(fontSize: 30, color: Colors.purpleAccent),
                ),
              ),
            )),
          ],
        ),
        RotationTransition(
          turns: _controller,
          child: Center(
            child: Container(
              width: 150,
              height: 150,
              color: Colors.red,
              child: ScaleTransition(
                scale: _controller.drive(Tween(begin: 1.0, end: 15.0)),
                child: Center(
                  child: Text(
                    "卍",
                    style: TextStyle(fontSize: 30, color: Colors.limeAccent),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Wrap(
          spacing: 10,
          children: [
            OutlinedButton(
                onPressed: () {
                  _controller.repeat();
                },
                child: Text("repeat")),
            OutlinedButton(
                onPressed: () {
                  _controller.stop();
                },
                child: Text("stop")),
            OutlinedButton(
                onPressed: () {
                  _controller.repeat(reverse: true);
                },
                child: Text("reverse")),
            OutlinedButton(
                onPressed: () {
                  _controller.reset();
                },
                child: Text("reset")),
          ],
        ),
      ],
    );
  }
}
