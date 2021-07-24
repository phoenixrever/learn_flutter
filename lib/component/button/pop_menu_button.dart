import 'package:flutter/material.dart';

class PopMenu extends StatefulWidget {
  const PopMenu({
    Key? key,
  }) : super(key: key);

  @override
  _PopMenuState createState() => _PopMenuState();
}

class _PopMenuState extends State<PopMenu> {
  String _currentMenuItem = "Home";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text("PopupMenuButton"),
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.amberAccent,
                  ))),
        ),
        Row(
          children: [
            Text(_currentMenuItem),
            PopupMenuButton<String>(
              ///child icon会替换掉点...图标
              // child: Text(_currentMenuItem),
                icon: Icon(Icons.more_horiz),
                onSelected: (value) {
                  print(value);
                  setState(() {
                    _currentMenuItem = value;
                  });
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: "橋本ありな", child: Text("橋本ありな")),
                  PopupMenuItem(value: "美波", child: Text("美波")),
                  PopupMenuItem(value: "水桜", child: Text("水桜")),
                ]),
          ],
        ),
      ],
    );
  }
}
