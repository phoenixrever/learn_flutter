import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenderObjectDemo extends StatefulWidget {
  const RenderObjectDemo({Key? key}) : super(key: key);

  @override
  _RenderObjectDemoState createState() => _RenderObjectDemoState();
}

class _RenderObjectDemoState extends State<RenderObjectDemo> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("render object"),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Container(
            color: Colors.pinkAccent,
            child: MyRenderBox(
              child: FlutterLogo(
                size: 150,
              ),
            ),
          ),
          Container(
            // color: Colors.deepPurpleAccent,
            //没有key的话 组件被复用 还是原来的组件 hot reload 没用
            child: ShadowBox(
              distance: 8.0,
              child: Icon(
                Icons.category,
                size: 150,
              ),
            ),
          ),
          Container(
            color: Colors.deepPurpleAccent,
            //没有key的话 组件被复用 还是原来的组件 hot reload 没用
            child: ShadowBox2(
              distance: 8.0,
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 150,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            label: "MyRenderBox",
            icon: Icon(Icons.group),
          ),
          BottomNavigationBarItem(
              label: "shadowBox", icon: Icon(Icons.wine_bar)),
          BottomNavigationBarItem(
              label: "shadowBox", icon: Icon(Icons.wine_bar)),
        ],
      ),
    );
  }
}

class MyRenderBox extends SingleChildRenderObjectWidget {
  MyRenderBox({required Widget child}) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMyRenderBox();
  }
}

class RenderMyRenderBox extends RenderBox with RenderObjectWithChildMixin {
  @override
  void performLayout() {
    // child!.layout(BoxConstraints.tight(Size(50,50)));
    //把父组件的尺寸传给子组件
    // print(constraints);//BoxConstraints(0.0<=w<=360.0, 0.0<=h<=692.0)

    //父组件想用子组件的尺寸来设置自身时候需要指名
    ///parentUsesSize: false 时候 组件重新布局时候能到达 relayout boundary
    ///子组件改变不影响父组件
    child!.layout(constraints, parentUsesSize: true);
    //自己的尺寸
    // size=Size(300,300);
    size = (child as RenderBox).size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset + Offset(50, 20));

    ///不影响其他组件布局
    context.canvas.drawCircle(
        offset + Offset(50, 50), 40, Paint()..color = Colors.orangeAccent);

    context.pushOpacity(offset + Offset(50, 50), 127, (context, offset) {
      context.paintChild(child!, Offset(0, 50));
    });
  }
}

class ShadowBox extends SingleChildRenderObjectWidget {
  final double distance;

  ShadowBox({required Widget child, this.distance = 8.0}) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderShadowBox(distance);
  }

  //没有key的话 组件被复用 还是原来的组件 hot reload 没用
  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    // renderObject.distance=distance;  不知道为什么报错
    print("renderObject.constraints");
    // print(renderObject.);
  }
}

class RenderShadowBox extends RenderBox with RenderObjectWithChildMixin {
  double distance;

  RenderShadowBox(this.distance);

  @override
  void performLayout() {
    // print(constraints);//BoxConstraints(0.0<=w<=360.0, 0.0<=h<=692.0)
    child!.layout(constraints, parentUsesSize: true);
    size = (child as RenderBox).size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);
    context.pushOpacity(offset, 127, (context, offset) {
      context.paintChild(child!, Offset(distance, distance));
    });
  }
}

class ShadowBox2 extends SingleChildRenderObjectWidget {
  final double distance;

  ShadowBox2({required Widget child, this.distance = 8.0})
      : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderShadowBox2(distance);
  }

  //没有key的话 组件被复用 还是原来的组件 hot reload 没用
  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    // renderObject.distance=distance;  不知道为什么报错
    print("renderObject.constraints");
    // print(renderObject.);
  }
}
//==============================================================================

class RenderShadowBox2 extends RenderProxyBox with DebugOverflowIndicatorMixin {
  double distance;

  RenderShadowBox2(this.distance);

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);
    context.pushOpacity(offset, 127, (context, offset) {
      context.paintChild(child!, Offset(distance, distance));
    });

    //containerRect能画的范围  childRect让你画的范围
    paintOverflowIndicator(
        context,
        offset,
        ///也能构建矩形
        Offset.zero & size,
        // Rect.fromLTWH(0, 0, size.width, size.height),
        Rect.fromLTWH(0, 0, 300, 300));
  }
}
