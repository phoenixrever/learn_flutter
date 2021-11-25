import 'package:flutter/material.dart';

class MultiAnimation extends StatefulWidget {
  const MultiAnimation({Key? key}) : super(key: key);

  @override
  _MultiAnimationState createState() => _MultiAnimationState();
}

class _MultiAnimationState extends State<MultiAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
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
    return Center(
      child: Column(
        children: [
          SlideTransition(
              position:
                  Tween<Offset>(begin: Offset(-0.1, 0), end: Offset(0.1, 0))
                      .chain(CurveTween(curve: Interval(0, 0.2)))
                      .chain(CurveTween(curve: Curves.linear))
                      .animate(_controller),
              child: Container(
                width: 200,
                height: 100,
                color: Colors.blue[100],
              )),
          SlideTransition(
              position:
                  Tween<Offset>(begin: Offset(-0.1, 0), end: Offset(0.1, 0))
                      .chain(CurveTween(curve: Interval(0.2, 0.4)))
                      .animate(_controller),
              child: Container(
                width: 200,
                height: 100,
                color: Colors.blue[300],
              )),
          ScaleTransition(
            scale: Tween(begin: 1.0, end: 1.5)
                .chain(CurveTween(curve: Interval(0.4, 0.6)))
                .animate(_controller),
            child: FadeTransition(
                // position: Tween<Offset>(begin: Offset(-0.1,0),end: Offset(0.1,0))
                //     .chain(CurveTween(curve: Interval(0.4,0.6)))
                //     .animate(_controller),
                opacity: Tween(begin: 0.1, end: 1.0)
                    .chain(CurveTween(curve: Interval(0.4, 0.6)))
                    .animate(_controller),
                child: Container(
                  width: 200,
                  height: 100,
                  color: Colors.blue[500],
                )),
          ),
          SlideTransition(
              position:
                  Tween<Offset>(begin: Offset(-0.1, 0), end: Offset(0.1, 0))
                      .chain(CurveTween(curve: Interval(0.6, 0.8)))
                      .animate(_controller),
              child: Container(
                width: 200,
                height: 100,
                color: Colors.blue[700],
              )),
          SlideTransition(
              position:
                  Tween<Offset>(begin: Offset(-0.1, 0), end: Offset(0.1, 0))
                      .chain(CurveTween(curve: Interval(0.8, 1)))
                      .animate(_controller),
              child: Container(
                width: 200,
                height: 100,
                color: Colors.blue[900],
              )),
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
      ),
    );
  }
}
