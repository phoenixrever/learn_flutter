import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedWidgetDemo extends StatefulWidget {
  const AnimatedWidgetDemo({
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedWidgetDemoState createState() => _AnimatedWidgetDemoState();
}

class _AnimatedWidgetDemoState extends State<AnimatedWidgetDemo> {
  double _height = 200;
  Color _color = Colors.orange;
  Color _color2 = Colors.white;
  String _text = '橋本ありな';
  double _circular = 8;
  TileMode _tileMode = TileMode.mirror;
  double _blurRadius = 50;

  double _moonX = 10;
  double _moonY = 60;

  double _withOpacity = 1;
  bool switcher = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: AnimatedContainer(
            height: _height,
            width: 200,
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [_color, Colors.white],
                  //超出边界的颜色显示效果  decal无 mirror 光圈
                  tileMode: _tileMode,
                ),
                boxShadow: [
                  BoxShadow(
                    ///边框厚度
                    spreadRadius: 5,

                    ///模糊光影
                    blurRadius: _blurRadius,
                  ),
                ],
                borderRadius: BorderRadius.circular(_circular)),
            child: Center(
              ///child组件没有动画
              child: Text(
                "$_text",
                style: TextStyle(color: Colors.white),
              ),
            ),
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
                    _height = 100;
                    _color = Colors.red;
                    _text = "水と桜";
                    _circular = 50;
                    _tileMode = TileMode.decal;
                    _blurRadius = 10;
                    _color2 = Colors.black;
                    _withOpacity = 0.1;
                    _moonX = 60;
                    _moonY = 10;
                    switcher = true;
                  });
                },
                child: Text("start")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _height = 200;
                    _color = Colors.orange;
                    _text = '橋本ありな';
                    _circular = 8;
                    _tileMode = TileMode.mirror;
                    _blurRadius = 50;
                    _color2 = Colors.white;
                    _withOpacity = 1;
                    _moonX = 10;
                    _moonY = 60;
                    switcher = false;
                  });
                },
                child: Text("reset")),
          ],
        ),
        AnimatedContainer(
          height: 300,
          width: double.infinity,
          alignment: Alignment.topLeft,
          duration: Duration(seconds: 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.0, 0.4],
              colors: [Colors.blue.withOpacity(_withOpacity), _color2],
              //超出边界的颜色显示效果  decal无 mirror 光圈
            ),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(seconds: 3),
                left: _moonX,
                top: _moonY,
                child: AnimatedContainer(
                  duration: Duration(seconds: 3),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white70,
                          spreadRadius: 3,
                          blurRadius: 30,

                          ///改变shadow的位置
                          offset: Offset(0, 0),
                        ),
                      ],
                      shape: BoxShape.circle),
                ),
              ),
              ...List.generate(10, (index) {
                return Positioned(
                    top: Random().nextDouble() * 100,
                    right: Random().nextDouble() * 100,
                    child: Icon(Icons.star, size: 15, color: Colors.white));
              }),

              ///================ AnimatedSwitcher AnimatedCrossFade==============================
              Align(
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 3),
                    child: switcher
                        ? SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.network(
                          "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F01.minipic.eastday.com%2F20170516%2F20170516110942_ab52e9807007d5a76950d623919226a4_2.jpeg&refer=http%3A%2F%2F01.minipic.eastday.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1630145152&t=d626934253e7b422ef777cfcc8e129ae"),
                    )
                        : Text("AnimatedSwitcher"),
                  )),

              ///================ AnimatedSwitcher相同控件复用原因需要key==============================
              Positioned(
                  right: 20,
                  bottom: 20,
                  child: AnimatedSwitcher(
                    transitionBuilder: (child, animation) {
                      //默认
                      // return FadeTransition(opacity: animation,child: child,)
                      // return RotationTransition(turns: animation,child: child);
                      return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ));
                    },
                    duration: Duration(seconds: 3),
                    child: switcher
                        ? Text(
                      "SwitchText",
                      key: UniqueKey(),
                    )
                        : Text(
                      "頑張れ",
                      key: UniqueKey(),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

///不行 一样造成shadow 失效
/// ClipPath( clipper: MyClipper(),
class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
