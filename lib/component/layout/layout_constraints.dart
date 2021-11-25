import 'package:flutter/material.dart';

class LayoutConstraints extends StatefulWidget {
  const LayoutConstraints({Key? key}) : super(key: key);

  @override
  _LayoutConstraintsState createState() => _LayoutConstraintsState();
}

class _LayoutConstraintsState extends State<LayoutConstraints> {
  double _maxHeight=0;
  double _maxWidth=0;
  double _minHeight=0;
  double _minWidth=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("constraints"),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          color: Colors.red[200],
          //设置比例
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 0.5,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 80,
                  minHeight:80,
                  maxHeight: 120,
                  maxWidth: 120
                    //loosen松约束 min为0 BoxConstraints(0.0<=w<=120.0, 0.0<=h<=120.0
                ).loosen(),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    //BoxConstraints(w=200.0, h=200.0)
                    //center  BoxConstraints(0.0<=w<=200.0, 0.0<=h<=200.0)
                    //ConstrainedBox  BoxConstraints(80.0<=w<=120.0, 80.0<=h<=120.0)
                    print(constraints);
                    return FlutterLogo(size: 100 ,);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      // persistentFooterButtons: [
      //   Wrap(
      //     children: [
      //       TextButton(onPressed: () {}, child: Text("_maxHeight:$_maxHeight")),
      //       TextButton(onPressed: () {}, child: Text("_maxHeight:$_maxWidth")),
      //       TextButton(onPressed: () {}, child: Text("_maxHeight:$_minHeight")),
      //       TextButton(onPressed: () {}, child: Text("_maxHeight:$_minWidth")),
      //     ],
      //   ),
      // ],
    );
  }
}
