import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_flutter/component/other/hollowed_text.dart';
import 'package:learn_flutter/component/route_button.dart';

class OtherDemo extends StatelessWidget {
  const OtherDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(16),
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 40),
      children: [
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "cross-fade",
          to: "cross-fade",
        ),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "small widget",
          to: "small-widget",
        ),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: MyHollowedText(text: "hollowed-text",color: Colors.white,fontSize: 20,strokeWidth: 0.5,),
          to: "hollowed-text",
        ),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "build context",
          to: "build-context",
        ),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "water marker",
          to: "water-marker",
        ),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "count down",
          to: "count-down-demo",
        ),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "willpopscope",
          to: "will-pop-scope",
        ),
      ],
    );
  }
}
