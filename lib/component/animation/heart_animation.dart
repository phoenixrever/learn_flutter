import 'package:flutter/material.dart';

class HeartAnimation extends StatefulWidget {
  const HeartAnimation({Key? key}) : super(key: key);

  @override
  _HeartAnimationState createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation> with TickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation _animation;
  late Animation _animationColor;
  late CurvedAnimation _curvedAnimation;
  late Curve _curve;
  String label = 'bounceOut';

  List<Map> curves = [
    {
      "linear": Curves.linear,
    },
    {
      "bounceOut": Curves.bounceOut,
    },
    {
      "bounceIn": Curves.bounceIn,
    },
    {
      "bounceInOut": Curves.bounceInOut,
    },
    {
      "decelerate": Curves.decelerate,
    },
    {
      "easeInOutCirc": Curves.easeInOutCirc,
    },
    {
      "ease": Curves.ease,
    },
    {
      "easeIn": Curves.easeIn,
    },
    {
      "easeInOut": Curves.easeInOut,
    },
    {
      "easeInBack": Curves.easeInBack,
    },
    {
      "easeInCirc": Curves.easeInCirc,
    },
    {
      "easeInCubic": Curves.easeInCubic,
    },
    {
      "easeInOutCirc": Curves.easeInOutCirc,
    },
    {
      "easeInExpo": Curves.easeInExpo,
    },
    {
      "easeInOutBack": Curves.easeInOutBack,
    },
    {
      "easeInOutCubic": Curves.easeInOutCubic,
    },
    {
      "easeInOutExpo": Curves.easeInOutExpo,
    },
    {
      "easeInOutQuad": Curves.easeInOutQuad,
    },
    {
      "easeOutQuart": Curves.easeOutQuart,
    },
    {
      "easeInOutQuint": Curves.easeInOutQuint,
    },
    {
      "easeOutSine": Curves.easeOutSine,
    },
    {
      "easeInQuad": Curves.easeInQuad,
    },
    {
      "easeInQuart": Curves.easeInQuart,
    },
    {
      "easeInQuint": Curves.easeInQuint,
    },
    {
      "slowMiddle": Curves.slowMiddle,
    },
    {
      "easeInQuint": Curves.easeInQuint,
    },
    {
      "linearToEaseOut": Curves.linearToEaseOut,
    },
    {
      "fastLinearToSlowEaseIn": Curves.fastLinearToSlowEaseIn,
    },
    {
      "elasticOut": Curves.elasticOut,
    },
    {
      "elasticIn": Curves.elasticIn,
    },
    {
      "easeOutExpo": Curves.easeOutExpo,
    },
    {
      "decelerate": Curves.decelerate,
    },
    {
      "fastOutSlowIn": Curves.fastOutSlowIn,
    },
  ];

  @override
  void initState() {
    super.initState();
    initAnimate();
  }

  void initAnimate() {
    _animationController = AnimationController(
      //初始值
      // value: 25,
      // lowerBound: 25.0,
      // upperBound: 100.0,
        duration: Duration(milliseconds: 3000),
        vsync: this);

    _curve = Curves.bounceOut;
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: _curve);

    ///注册动画对象
    _animation = Tween(
      begin: 32.0,
      end: 100.0,
    ).animate(_curvedAnimation);
    _animationColor = ColorTween(
      begin: Colors.red,
      end: Colors.red[900],
    ).animate(_curvedAnimation);

    ///继承AnimatedWidget 会自动listener
    // _animationController.addListener(() {
    //   // print("$_animationController.value");
    //
    //   //通知ui value改变了
    //   setState(() {});
    // });

    ///动画运行状态
    _animationController.addStatusListener((AnimationStatus status) {
      print("$status");
    });

    ///开始播放动画
    // _animationController.forward();
  }

  void changeAnimate(Curve curve) {
    _curve = curve;
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: _curve);

    //注册动画对象
    _animation = Tween(
      begin: 32.0,
      end: 100.0,
    ).animate(_curvedAnimation);
    _animationColor = ColorTween(
      begin: Colors.red,
      end: Colors.red[900],
    ).animate(_curvedAnimation);
  }

  ///销毁控制器
  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            // ActionChip(
            //     // label: Text("${_animationController.value}"),
            //     label: Text("${_animation.value}"),
            //     onPressed: () {
            //       _animationController.forward();
            //     }),
            Row(
              children: [
                SizedBox(width: 100, child: Text("$label")),
                SizedBox(
                  height: 150,
                  child: Center(
                    child: AnimatedHeart(
                      animations: [_animation, _animationColor],
                      controller: _animationController,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Wrap(
              spacing: 5,
              children: [
                ...List.generate(
                    curves.length,
                        (index) => ActionChip(
                        label: Text(curves[index].keys.elementAt(0)),
                        onPressed: () {
                          setState(() {
                            label = curves[index].keys.elementAt(0);
                            changeAnimate(
                                curves[index].values.elementAt(0));
                          });
                        }))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedHeart extends AnimatedWidget {
  final List animations;
  final AnimationController controller;

  AnimatedHeart({required this.animations, required this.controller})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.favorite,
          color: animations[1].value,
        ),
        iconSize: animations[0].value,
        onPressed: () {
          switch (controller.status) {
            case AnimationStatus.completed:
              controller.reverse();
              break;
            default:
              controller.forward();
          }
        });
  }
}
