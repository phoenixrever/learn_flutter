import 'package:flutter/material.dart';

class TitleDivider extends StatelessWidget {
  const TitleDivider(
      {Key? key,
      required this.title,
      this.bottomPadding = 2,
      this.margin = 10,
      this.bottomWidth = 2,
      this.bottomColor = Colors.amberAccent})
      : super(key: key);
  final String title;
  final double bottomPadding;
  final double margin;
  final double bottomWidth;
  final Color bottomColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text("$title"),
      margin: EdgeInsets.symmetric(vertical: margin),
      padding: EdgeInsets.only(bottom: bottomPadding),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: bottomWidth,
        color: bottomColor,
      ))),
    );
  }
}
