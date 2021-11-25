import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaterMarker extends StatelessWidget {
  const WaterMarker({Key? key}) : super(key: key);
  final String? watermark = "拆";

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        home: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("标题"),
              backgroundColor: CupertinoColors.white,
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.cyan[400]!,
                Colors.purple[300]!,
                Colors.pink[200]!,
              ],
              ///2个数字之间是渐变的区间
                stops: [0, 0.5, 1],
                begin: Alignment(-0.5, -0.9),
                end: Alignment(1.5, 0.6))),
              child: ListView(
                children: [
                  SizedBox(
                    height: 200,
                    child: MyWaterMark(watermark: watermark),
                  ),
                  SizedBox(
                    height: 250,
                    child: Row(
                      children: [
                        Expanded(child: MyWaterMark(watermark: watermark)),
                        Expanded(child: MyWaterMark(watermark: watermark)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: MyWaterMark(watermark: watermark),
                  ),
                ],
              ),
            )));
  }
}

class MyWaterMark extends StatelessWidget {
  const MyWaterMark({
    Key? key,
    required this.watermark,
  }) : super(key: key);

  final String? watermark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ///类似material card
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: CupertinoPopupSurface(

              ///false只有毛玻璃效果不给上色
              // isSurfacePainted: false,

            ///BackdropFilter 会模糊被child挡住的内容 适合做弹出框  image是模糊child
              child: ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaX: watermark == null ? 0 : 2,
                sigmaY: watermark == null ? 0 : 2),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FlutterLogo(
                style: FlutterLogoStyle.horizontal,
              ),
            ),
          )),
        ),
        if (watermark != null)
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // return Center(
              //   child: SizedBox(
              //     ///在给定的界面里面根据最短边画个正方形
              //     width: constraints.biggest.shortestSide,
              //     height: constraints.biggest.shortestSide,
              //     child: Transform.rotate(
              //         angle: -pi /4,
              //         child: FittedBox(
              //           child: Container(
              //             decoration: BoxDecoration(
              //               border: Border.all(color: Colors.red,width: 2),
              //               shape: BoxShape.circle
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.all(4.0),
              //               child: Text("$watermark",style: TextStyle(color: Colors.red),),
              //             ),
              //           ),
              //         )),
              //   ),
              // );
              return Center(
                child: AspectRatio(
                  aspectRatio: 01,
                  child: Container(
                    // color: Colors.yellowAccent.withOpacity(0.3),
                    child: Transform.rotate(
                        angle: -pi /4,
                        child: FittedBox(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red,width: 2),
                                shape: BoxShape.circle
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("$watermark",style: TextStyle(color: Colors.red),),
                            ),
                          ),
                        )),
                  ),
                ),
              );
            },
          )
      ],
    );
  }
}
