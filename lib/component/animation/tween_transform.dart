import 'dart:math';

import 'package:flutter/material.dart';

class TweenTransform extends StatefulWidget  {
  const TweenTransform({
    Key? key,
  }) : super(key: key);

  @override
  _TweenTransformState createState() => _TweenTransformState();
}

class _TweenTransformState extends State<TweenTransform> with SingleTickerProviderStateMixin {
  double _opacity = 1;
  double _padding = 0;
  double _scale = 1.0;
  //0~2pi
  double _angle =0;
  double _offsetX =0;
  double _offsetY=0;
  ///=========================未完成===========================
  ///final AnimationController controller;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedPadding(
        padding: EdgeInsets.only(top: _padding),
        duration: Duration(seconds: 2),
        curve: Curves.bounceOut,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: _opacity,
                curve: Curves.bounceInOut,
                duration: Duration(seconds: 2),
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.pinkAccent,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                spacing: 20,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _opacity = 0.2;
                          _padding = 100;
                          _scale = 10;
                          _angle = 2*pi;
                          _offsetX = 0;
                          _offsetY = -400;
                        });
                      },
                      child: Text("start")),
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _opacity = 1;
                          _padding = 0;
                          _scale = 1;
                          _angle = 0;
                          _offsetX = 0;
                          _offsetY = 0;
                        });
                      },
                      child: Text("reset")),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                spacing: 10,
                children: [
                  TweenAnimationBuilder(
                    duration: Duration(seconds: 2),
                    ///begin 只会在开始时候有用 后面就只会改end的值
                    tween: Tween<double>(begin: 1, end:_scale),

                    ///tween 时间内 每一帧不停的调用builder函数并传入参数value
                    builder: (BuildContext context, double value, Widget? child) {
                      return Container(
                        width:80,
                        height: 80,
                        color: Colors.lightBlue,
                        child: Center(
                          child: Transform.scale(
                            scale:value ,
                            child: Text(
                              "卍",
                              style:
                              TextStyle(fontSize: 20 , color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  TweenAnimationBuilder(
                    duration: Duration(seconds: 2),
                    ///begin 只会在开始时候有用 后面就只会改end的值
                    tween: Tween<double>(begin: 0, end:_angle),

                    ///tween 时间内 每一帧不停的调用builder函数并传入参数value
                    builder: (BuildContext context, double value, Widget? child) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.orangeAccent,
                        child: Center(
                          child: Transform.rotate(
                            angle:value ,
                            child: Text(
                              "卍",
                              style:
                              TextStyle(fontSize: 30 , color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  TweenAnimationBuilder(
                    duration: Duration(seconds: 2),
                    ///begin 只会在开始时候有用 后面就只会改end的值
                    tween: Tween<Offset>(begin: Offset(0,0),end: Offset(_offsetX,_offsetY)),
                    ///tween 时间内 每一帧不停的调用builder函数并传入参数value
                    builder: (BuildContext context, Offset value, Widget? child) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.limeAccent,
                        child: Center(
                          child: Transform.translate(
                            offset: value,
                            child: Text(
                              "卍",
                              style:
                              TextStyle(fontSize: 30 , color: Colors.red),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
