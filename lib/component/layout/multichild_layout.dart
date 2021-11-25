import 'package:flutter/material.dart';

class MultiChildLayout extends StatelessWidget {
  const MultiChildLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CustomMultiChildLayout"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.orangeAccent,
              child: CustomMultiChildLayout(
                delegate: MyMultiChildLayoutDelegate(),
                children: [
                  LayoutId(
                    id: 1,
                    //loose后 松约束 子组件的size 才起作用
                    child: FlutterLogo(
                      size: 50,
                    ),
                  ),
                  LayoutId(
                    id: 2,
                    child: FlutterLogo(),
                  ),
                  LayoutId(
                      id: "underLine",
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          // border: Border(
                          //     bottom: BorderSide(
                          //   width: 1,
                          // ))
                        ),
                      )),
                  LayoutId(
                      id: "text",
                      //loose后 松约束 子组件的size 才起作用
                      child: Text("下划线组件")),
                ],
              ),
            ),
          ),
          Expanded(child: Diagonal(children: [
            FlutterLogo(size: 100,),
            Text("11111"),
            Text("11111"),
            Text("11111"),
          ]))
        ],
      ),
    );
  }
}

class Diagonal extends StatelessWidget {
  final List<Widget> children;

  const Diagonal({
    Key? key,
    required,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomMultiChildLayout(
      delegate: PulginMultiChildLayoutDelegate(),
      children: [
        for (int i = 0; i < children.length; i++)
          LayoutId(
            id: i,
            child: children[i],
          )
      ],
    ));
  }
}

class PulginMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Offset offset = Offset.zero;
    for (int i = 0;; i++) {
      if (hasChild(i)) {
        final childSize = layoutChild(i, BoxConstraints.loose(size));
        positionChild(i, offset);
        offset += Offset(childSize.width, childSize.height);
      }else{
        break;
      }
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

///===================================================================

class MyMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  Size getSize(BoxConstraints constraints) {
    // return  constraints.biggest;
    return Size(500, 300);
  }

  @override
  void performLayout(Size size) {
    var childSize1;
    var childSize2;
    if (hasChild(1)) {
      //向下传递约束并得到向上传递的尺寸
      childSize1 = layoutChild(1, BoxConstraints.loose(size));
      positionChild(1, Offset(0, 0));
    }
    if (hasChild(2)) {
      childSize2 = layoutChild(
          2,
          BoxConstraints(
            minWidth: 100,
            minHeight: 100,
            maxWidth: 100,
            maxHeight: 100,
          ));
      positionChild(2, Offset(childSize1.width, childSize1.height));
    }

    var sizeText;
    var sizeUnderLine;
    var left;
    var top;
    if (hasChild("text")) {
      sizeText = layoutChild("text", BoxConstraints.loose(size));
      left = (size.width - sizeText.width) / 2;
      top = (size.height - sizeText.height) / 2;
      positionChild("text", Offset(left, top));
    }
    if (hasChild("underLine")) {
      sizeUnderLine = layoutChild(
          "underLine",
          BoxConstraints(
              maxWidth: sizeText.width,
              minWidth: sizeText.width,
              minHeight: 1,
              maxHeight: 100));
      // sizeUnderLine = layoutChild("underLine", BoxConstraints.tight(Size(sizeText.width,4)));
      positionChild("underLine", Offset(left, sizeText.height + top));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
