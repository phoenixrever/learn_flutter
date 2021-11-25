import 'package:flutter/material.dart';

class DismissibleDemo extends StatelessWidget {
  const DismissibleDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      //滚动过量的效果 回弹
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.phone),
          ),
          secondaryBackground: Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerRight,
            child: Text(
              "右滑",
              style: TextStyle(color: Colors.white),
            ),
          ),
          onDismissed: (direction) {
            print(direction); //DismissDirection.endToStart
          },
          confirmDismiss: (direction) async {
              return true;
          },
          onResize: () {
            print("删除完成重置UI 调用");
          },
          resizeDuration: Duration(seconds: 2),
          movementDuration: Duration(seconds: 5),
          ///超过这个数值才算滑动成功 默认0.4
          dismissThresholds: {DismissDirection.startToEnd:0.1,DismissDirection.endToStart:0.9},
          // direction:  DismissDirection.vertical,
          child: ListTile(
            leading: Icon(Icons.add),
            title: Text("$index"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }
}
