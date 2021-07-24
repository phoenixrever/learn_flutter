import 'dart:math';

import 'package:flutter/material.dart';

class RouteButton extends StatelessWidget {
  const RouteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            mainAxisExtent: 40),
        children: [
          ComponentRoute(
            begin: Color.fromRGBO(226, 174, 194, 0.611764705882353),
            end: Color.fromRGBO(243, 10, 116, 1.0),
            borderColor:
            Color.fromRGBO(199, 66, 117, 0.611764705882353),
            name: "sliver",
            to: "sliver",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(174, 181, 226, 0.611764705882353),
            end: Color.fromRGBO(10, 33, 243, 1.0),
            borderColor: Color.fromRGBO(4, 6, 186, 0.611764705882353),
            name: "form",
            to: "form",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(207, 229, 224, 0.396078431372549),
            end: Color.fromRGBO(10, 243, 216, 1.0),
            borderColor: Color.fromRGBO(4, 186, 165, 0.611764705882353),
            name: "component",
            to: "component",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(92, 95, 234, 0.3568627450980392),
            end: Color.fromRGBO(3, 21, 76, 1.0),
            borderColor: Color.fromRGBO(4, 22, 186, 0.611764705882353),
            name: "table",
            to: "table",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(234, 232, 92, 0.3568627450980392),
            end: Color.fromRGBO(76, 69, 3, 1.0),
            borderColor: Color.fromRGBO(78, 71, 5, 0.611764705882353),
            name: "card",
            to: "card",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(234, 104, 92, 0.3568627450980392),
            end: Color.fromRGBO(76, 18, 3, 1.0),
            borderColor: Color.fromRGBO(78, 26, 5, 1.0),
            name: "stepper",
            to: "stepper",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
            end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
            borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
            name: "InheritedWidget",
            to: "state",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
            end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
            borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
            name: "change-notifier",
            to: "change-notifier",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
            end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
            borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
            name: "value-notifier",
            to: "value-notifier",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
            end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
            borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
            name: "stream",
            to: "stream",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
            end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
            borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
            name: "rxdart",
            to: "rxdart",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
            end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
            borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
            name: "错误状态不要点....",
            to: "forbidden-bloc",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
            end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
            borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
            name: "http",
            to: "http",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
            end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
            borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
            name: "animation",
            to: "animation",
          ),
          ComponentRoute(
            begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
            end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
            borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
            name: "localizations",
            to: "localizations",
          ),

        ],
      ),
    );
  }
}

class ComponentRoute extends StatelessWidget {
  const ComponentRoute({
    Key? key,
    required this.begin,
    required this.end,
    required this.borderColor,
    required this.name,
    required this.to,
  }) : super(key: key);

  final Color begin;
  final Color end;
  final Color borderColor;
  final String name, to;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 14,
      color: Colors.transparent,
      child: Ink(
        width: 250,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor, width:0),
            borderRadius: BorderRadius.circular(16),
            gradient: RadialGradient(
              //范围不够大时候的覆盖效果
              // tileMode: TileMode.mirror,
              ///中心的扩大范围
                radius: 2,
                colors: [
                  begin,
                  end,
                ])),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.pushNamed(context, "$to");
          },
          child: Center(
              child: Text(
                "$name",
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
              )),
        ),
      ),
    );
  }
}
