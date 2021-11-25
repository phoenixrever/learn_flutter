import 'package:flutter/material.dart';

class AnimatedCrossFadeDemo extends StatefulWidget {
  const AnimatedCrossFadeDemo({Key? key}) : super(key: key);

  @override
  _AnimatedCrossFadeDemoState createState() => _AnimatedCrossFadeDemoState();
}

class _AnimatedCrossFadeDemoState extends State<AnimatedCrossFadeDemo> {
  bool _showFirst = true;
  final String _img1 =
      "http://www.easystylenow.com/wp-content/uploads/2019/11/QQ%E6%88%AA%E5%9B%BE20191105184521.jpg";
  final String _img2 =
      "http://www.easystylenow.com/wp-content/uploads/2021/03/QQ截图20210315141511.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedCrossFadeDemo"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showFirst = !_showFirst;
              });
            },
            child: AnimatedCrossFade(
              firstChild: InteractiveViewer(
                ///放大后true 一根手指可以移动 false 需要2根
                panEnabled: true,

                ///缩小后有边距
                // boundaryMargin: EdgeInsets.all(100),
                child: Image.network(
                  _img1, fit: BoxFit.contain,
                  // height: MediaQuery.of(context).size.height
                ),
              ),
              secondChild: InteractiveViewer(
                child: Image.network(
                  _img2, fit: BoxFit.contain,
                  // height: MediaQuery.of(context).size.height
                ),
              ),
              // firstCurve:LinearHalfCurve(),
              // secondCurve: LinearHalfCurve().flipped,
              // firstCurve: Curves.easeOutExpo,
              // secondCurve: Curves.easeInBack,
              firstCurve: Interval(0, 0.5),
              secondCurve: Interval(0.5, 1.0),
              duration: Duration(seconds: 2),
              crossFadeState: _showFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.star),
            label: Text("投币"),
            style: OutlinedButton.styleFrom(
            backgroundColor: Colors.amber,
            primary: Colors.red,
            side: BorderSide(color: Colors.red,width: 2.0),
            /// Stadium 体育场;
            shape:StadiumBorder(),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            ),
            // style: ButtonStyle(
            //   /// all 各个状态下都是一样的值
            //   // backgroundColor: MaterialStateProperty.all(Colors.red[200]),
            //   backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            //     if(states.contains(MaterialState.selected)){
            //       return Colors.red;
            //     }
            //     return Colors.cyanAccent;
            //   }),
            //     side:MaterialStateProperty.all(BorderSide(width: 2.0,color: Colors.blue)),
            //
            //     shape: MaterialStateProperty.all(StadiumBorder())
            //     // shape: ButtonStyleButton.allOrNull(StadiumBorder()),
            //     // side: ButtonStyleButton.allOrNull(BorderSide(width: 2.0,color: Colors.blue))
            // )
          ),
          Row(
            ///设置row的宽度包裹里面的元素
            mainAxisSize: MainAxisSize.min,
          )
        ],
      ),
    );
  }
}

class LinearHalfCurve extends Curve {
  @override
  double transformInternal(double t) {
    if (t < 0.5) {
      return t * 2;
    }
    return 1.0;
  }
}
