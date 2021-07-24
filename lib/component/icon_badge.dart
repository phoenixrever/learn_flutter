import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  const IconBadge({Key? key, required this.iconData, double? size})
      : size = size ?? 35.0,
        super(key: key);

  final IconData iconData;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size+60,
      height: size+60,
      child: Icon(iconData,size: size,color: Colors.white,),
      color: Color.fromRGBO(3, 54, 255, 1.0),
    );
  }
}
