import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
class RxdartDemo extends StatefulWidget {
  const RxdartDemo({Key? key}) : super(key: key);

  @override
  _RxdartDemoState createState() => _RxdartDemoState();
}

class _RxdartDemoState extends State<RxdartDemo> {

  @override
  void initState() {
    super.initState();
    Stream streamA = Stream.fromIterable(['helloA',"橋本桜"]);
    Stream streamB = Stream.fromIterable(['helloB',"橋本桜"]);
    Stream stream = Rx.combineLatest2(streamA, streamB, (a, b) => "this is print");
    stream.listen(print);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('rxdart')),
      body: Container(),
    );
  }
}
