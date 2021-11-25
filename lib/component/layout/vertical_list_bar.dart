import 'package:flutter/material.dart';

class VerticalListBar extends StatefulWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color indicatorColor;
  final double indicatorWidth;
  final int count;
  final List<Widget> children;
  final Function(int index) onSelected;

  VerticalListBar(
      {this.width = 100.0,
      this.height = 50,
      this.backgroundColor = const Color(0xFFE0E0E0),
      this.indicatorColor = Colors.red,
      this.indicatorWidth = 3.0,
      required this.count,
      required this.children,
      required this.onSelected});

  @override
  _VerticalListBarState createState() => _VerticalListBarState();
}

class _VerticalListBarState extends State<VerticalListBar> {
  int _selectedIndex = 0;

  ScrollController _scrollController = ScrollController();
  double _top = 0;
  bool isFixed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Stack(
        children: [
          isFixed == false
              ? AnimatedPositioned(
                  duration: Duration(milliseconds: 250),
                  top: _top,
                  child: Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      border: Border(
                          right: BorderSide(
                              width: widget.indicatorWidth,
                              color: widget.indicatorColor)),
                    ),
                  ))
              : SizedBox(
                  width: 100,
                ),
          NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                setState(() {
                  isFixed = true;
                });
              }
              if (notification is ScrollEndNotification) {
                setState(() {
                  isFixed = false;
                  _top =
                      _selectedIndex * widget.height - _scrollController.offset;
                });
              }
              return true;
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.count,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      _top = index * widget.height - _scrollController.offset;
                      widget.onSelected(index);
                    });
                  },
                  child: Container(
                      height: widget.height,
                      width: widget.width,
                      decoration: isFixed && _selectedIndex == index
                          ? BoxDecoration(
                              color: widget.backgroundColor,
                              border: Border(
                                  right: BorderSide(
                                      width: widget.indicatorWidth,
                                      color: widget.indicatorColor)),
                            )
                          : BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: widget.indicatorWidth,
                                      color: Colors.transparent)),
                            ),
                      child: widget.children[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
