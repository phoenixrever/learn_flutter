import 'package:flutter/material.dart';

class CircleAnimationDemo extends StatefulWidget {
  const CircleAnimationDemo({Key? key}) : super(key: key);

  @override
  _CircleAnimationDemoState createState() => _CircleAnimationDemoState();
}

///ticker 每帧  每过一帧都会回传的意思
class _CircleAnimationDemoState extends State<CircleAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _controllerValue=0.0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _controller.addListener(() {
      // print('${_controller.value}');
      setState(() {
        _controllerValue=_controller.value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Chip(label: Text('$_controllerValue')),
          SizedBox(height: 20,),
          RotationTransition(
            turns: _controller,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.purpleAccent,
            ),
          ),
          SizedBox(height: 30,),
          FadeTransition(
            opacity: _controller,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 30,),
          ScaleTransition(
            scale: _controller,
            child: Icon(Icons.two_wheeler_sharp,size: 100,),
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),
          SizedBox(
            height: 50,
          ),
          Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                  onPressed: () {
                    // _controller.forward();
                    _controller.repeat();
                  },
                  child: Text("start")),
              ElevatedButton(
                  onPressed: () {
                    // _controller.forward();
                    _controller.stop();
                  },
                  child: Text("stop")),
              ElevatedButton(
                  onPressed: () {
                    // _controller.forward();
                    _controller.reset();
                  },
                  child: Text("reset")),
              ElevatedButton(
                  onPressed: () {
                    // _controller.forward();
                    _controller.repeat(reverse: true);
                  },
                  child: Text("reverse")),
            ],
          )
        ],
      ),
    );
  }
}
