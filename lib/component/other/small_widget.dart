import 'dart:math';

import 'package:flutter/material.dart';

class SmallWidgetsDemo extends StatefulWidget {
  const SmallWidgetsDemo({Key? key}) : super(key: key);

  @override
  _SmallWidgetsDemoState createState() => _SmallWidgetsDemoState();
}

class _SmallWidgetsDemoState extends State<SmallWidgetsDemo> {
  @override
  Widget build(BuildContext context) {
    final span = TextSpan(text: "secret", style: TextStyle(fontSize: 10));

    ///为了获取text的高度
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr)
      ..layout();

    double _width = tp.width * 2;
    double _height = tp.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("small widget"),
        centerTitle: true,
      ),
      ///.merge 合并上级的style
      body: AnimatedDefaultTextStyle(
        duration: Duration(seconds: 2),
        style: TextStyle(color: Colors.blue),
        child: InteractiveViewer(
          ///不约束子组件的尺寸
          constrained: false,
          child: ListView(
            children: [
              Container(
                height: 200,
                child: Center(
                  child: ClipRect(
                    child: Stack(
                      /// stack默认裁剪未生效的原因是应为positioned 组件
                      /// 的位移都没有负数 认为组件仍在stack无需裁剪
                      /// 位移设置负值会触发 如 right:-0.01
                      clipBehavior: Clip.hardEdge,
                      children: [
                        Container(
                          width: 250,
                          height: 100,
                          color: Colors.blue,
                        ),
                        Positioned(
                          right: 0,
                          top: sqrt(_width * _width / 2 -
                              sqrt2 * _width * _height +
                              _height * _height),
                          child: Transform.rotate(
                            angle: pi / 4,

                            /// 以哪位圆心旋转
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: _width,
                              height: _height,
                              color: Colors.red,
                              child: Center(child: RichText(text: span)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 200,
                child: Center(
                  child: ClipRect(
                    child: Banner(
                        message: "secret",
                        location: BannerLocation.topEnd,
                        child: Container(
                            width: 250,
                            height: 100,
                            color: Colors.amber,
                            child: FlutterLogo())),
                  ),
                ),
              ),
              ChangeButton(),
              FittedBox(
                ///只会向下缩小 不会放大
                // fit: BoxFit.scaleDown,
                child: Text("text大小自适应外部空间"),
              ),
              SafeArea(
                minimum: EdgeInsets.all(8),
                child: Text("safearea"),
              ),
              Container(
                  width: 300,
                  height: 100,
                  color: Colors.grey,
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Text(
                          "LayoutBuilder 能拿到父容器大小 maxWidth:${constraints.maxWidth} maxHeight:${constraints.maxHeight}");
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeButton extends StatefulWidget {
  @override
  _ChangeButtonState createState() => _ChangeButtonState();
}

class _ChangeButtonState extends State<ChangeButton> {
  double _width = 150;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: _width,
        height: 50,
        child: Material(
          elevation: 4,
          color: Colors.purple,
          shape: StadiumBorder(),
          child: InkWell(
            customBorder: StadiumBorder(),
            onTap: () {
              setState(() {
                _width = _width == 150 ? 50 : 150;
              });
            },
            child: Center(
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      _width == 150 ? "big" : "small",
                      key: UniqueKey(),
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ),
      ),
    );
  }
}
