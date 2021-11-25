import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomAnimation extends StatefulWidget {
  const CustomAnimation({Key? key}) : super(key: key);

  @override
  _CustomAnimationState createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _opacityController;
  late Animation heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _opacityController = AnimationController(vsync: this);


    heightAnimation = Tween(begin: 0.5, end: 1.0).animate(_controller);

    //自定义ticker
    //  Ticker ticker = Ticker((duration){
    //   print ("ticker: $duration");
    // });
    // ticker.start();
  }

  @override
  void dispose() {
    _controller.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///animatedWidget  控件每一帧都会重画 继承AnimatedWidget 会自动listener
        ///_animationController.addListener
        AnimatedBuilder(
          animation: _controller,
          child: Center(child: Text("not change part")),
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: heightAnimation.value,
              child: Container(
                width: 150,
                height: Tween(begin: 50.0, end: 150.0).evaluate(_controller),
                color: Colors.purpleAccent,
                child: child,
              ),
            );
          },
        ),
        Wrap(
          spacing: 10,
          children: [
            OutlinedButton(
                onPressed: () async {
                  _controller.duration=Duration(seconds: 4);
                  _controller.forward();
                  await Future.delayed(Duration(seconds: 4));

                  _opacityController.duration=Duration(milliseconds:1750);
                  _opacityController.repeat(reverse: true);
                  await Future.delayed(Duration(seconds: 7));
                  _opacityController.reset();

                  _controller.duration=Duration(seconds: 8);
                  _controller.reverse();
                },
                child: Text("start")),
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
            OutlinedButton(
                onPressed: ()  {
                  _controller.repeat();
                },
                child: Text("repeat")),
          ],
        ),
        FadeTransition(
          opacity:Tween(begin: 1.0,end: 0.1).animate(_opacityController),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Colors.blue, Colors.white],
                      // stops: _controller.value <= 0.2
                      //     ? [animation1.value, animation1.value + 0.1]
                      //     : [animation3.value, animation3.value + 0.1],
                      stops: [_controller.value,_controller.value+0.1],
                      tileMode: TileMode.mirror,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                      )
                    ]),
              );
            },
          ),
        )
      ],
    );
  }
}
