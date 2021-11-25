import 'dart:math';

import 'package:flutter/material.dart';

import '../route_button.dart';

class LayoutRoute extends StatelessWidget {
  const LayoutRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      physics: BouncingScrollPhysics(),
      children: [
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "constraints",
          to: "constraints",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "multichild",
          to: "multichild",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "render object",
          to: "renderObject",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "keydemo",
          to: "keydemo",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "key game",
          to: "key-game",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "future",
          to: "future",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "stream game",
          to: "stream-game",
        ),
      ],
    );
  }
}
