import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ElevatedButton(
            onPressed: null,
            child: Text("ElevatedButton disabled")),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              //背景颜色
              primary: Theme.of(context).primaryColor,
              //字体颜色
              onPrimary: Colors.greenAccent,
            ),
            onPressed: () {},
            child: Text("ElevatedButton")),
        ElevatedButton.icon(
          icon: Icon(Icons.adb),
          style: ElevatedButton.styleFrom(
            //背景颜色
              primary: Theme.of(context).primaryColor,
              //字体颜色
              onPrimary: Colors.greenAccent,
              elevation: 14),
          onPressed: () {},
          label: Text("ElevatedButtonIcon"),
        ),
        TextButton(
          child: Text("TextButton"),
          onPressed: () {},
          style: TextButton.styleFrom(
            //背景颜色
            primary: Theme.of(context).primaryColor,
            // backgroundColor: Colors.orangeAccent
          ),
        ),
        TextButton.icon(
          label: Text("TextButton"),
          onPressed: () {},
          style: TextButton.styleFrom(
            //背景颜色
              primary: Theme.of(context).primaryColor,
              backgroundColor: Colors.orangeAccent,
              elevation: 10),
          icon: Icon(Icons.opacity),
        ),
        OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(''' xxx ''')));
          },
          style: OutlinedButton.styleFrom(
            //字体
            primary: Colors.red,
            // backgroundColor: Theme.of(context).primaryColor,
            side:
            BorderSide(color: Colors.redAccent, width: 2),
          ),
          child: Text("OutlinedButton"),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //背景颜色
                    primary: Theme.of(context).primaryColor,
                    //字体颜色
                    onPrimary: Colors.greenAccent,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                        behavior:
                        SnackBarBehavior.floating,
                        content: Text('''flex 1''')));
                  },
                  child: Text("ElevatedButton")),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //背景颜色
                    primary: Theme.of(context).primaryColor,
                    //字体颜色
                    onPrimary: Colors.greenAccent,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                        behavior:
                        SnackBarBehavior.floating,
                        content: Text(''' flex2 ''')));
                  },
                  child: Text("ElevatedButton")),
            ),
          ],
        ),
        // Divider(height: 50.0,indent: 5.0,color: Colors.amberAccent,thickness: 2,),
        Container(
          child: Text("Button bar"),
          margin: EdgeInsets.symmetric(vertical: 30),
          padding: EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.amberAccent,
                  ))),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {}, child: Text("ButtonBar")),
            ElevatedButton(
                onPressed: () {}, child: Text("ButtonBar")),
          ],
        ),
      ],
    );
  }
}