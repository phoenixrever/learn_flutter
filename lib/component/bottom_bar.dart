import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final Function changeIndex;
  final int currentIndex;
  const BottomBar({
    Key? key, required this.changeIndex, required this.currentIndex,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index){
        ///用widget来调用父组件方法
        widget.changeIndex(index);
      },
      selectedFontSize:12.0 ,
      unselectedFontSize: 12.0,
      // unselectedItemColor: Colors.grey.withOpacity(0.8),
      ///超出4个需要设置
      type: BottomNavigationBarType.fixed,
      ///激活颜色
      // fixedColor: Colors.deepPurple,
      currentIndex: widget.currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.phone),
          label: "phone",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: "scroll",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit_outlined),
          label: "route",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit_outlined),
          label: "layout",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit_outlined),
          label: "other",
        ),
      ],
    );
  }
}
