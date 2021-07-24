import 'package:flutter/material.dart';
import 'package:learn_flutter/model/user.dart';

class CardDemo extends StatelessWidget {
  const CardDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("card".toUpperCase()),),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: ListView(
          children: users
              .map((e) => Card(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child:  ClipRRect(
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(4),topRight: Radius.circular(4)),
                            child: Image.network(
                              e.avatar,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(e.title),
                          minLeadingWidth: 0,
                          leading: Icon(Icons.car_rental),
                          trailing: Icon(Icons.arrow_forward_ios),
                          // selected: true,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "ssdddddddddddddddddsssssssssssssssssssssssssssssdddd",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ButtonBarTheme (
                          data: ButtonBarThemeData(),
                          child: ButtonBar(
                            children: [
                              TextButton(onPressed: (){}, child: Text("Like".toUpperCase()))
                            ],
                          )
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
