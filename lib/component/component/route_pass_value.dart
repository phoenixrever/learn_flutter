import 'package:flutter/material.dart';

class RoutePassValue extends StatefulWidget {
  const RoutePassValue({Key? key}) : super(key: key);

  @override
  _RoutePassValueState createState() => _RoutePassValueState();
}

class _RoutePassValueState extends State<RoutePassValue> {
  String returnValue = "准备接收";

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Column(
        children: [
          Text("接受的值为:$returnValue"),
          SizedBox(
            height: 50,
          ),
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ValueDemo();
            },)).then((value){setState(() {
              returnValue=value;
            });});
          }, child: Text("前进")),
          Card(

            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(''' 
          TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ValueDemo();
              },)).then((value){setState(() {
                returnValue=value;
              });});
          }, child: Text("前进"))
          '''),
            ),)
        ],
      ),
    ));
  }
}

class ValueDemo extends StatefulWidget {
  const ValueDemo({Key? key}) : super(key: key);

  @override
  _ValueDemoState createState() => _ValueDemoState();
}

class _ValueDemoState extends State<ValueDemo> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("传值"),),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textEditingController,
                onChanged: (_) {
                  print(_textEditingController.text);
                },
                decoration: InputDecoration(hintText: "Please Enter Text"),
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, _textEditingController.text);
                  },
                  child: Text("返回传值"))
            ],
          ),
        ),
      ),
    );
  }
}
