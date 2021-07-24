import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_flutter/network/http_request.dart';

class HttpDemo extends StatelessWidget {
  const HttpDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("http")),
      body: HttpBody(),
    );
  }
}

class HttpBody extends StatefulWidget {
  const HttpBody({Key? key}) : super(key: key);

  @override
  _HttpBodyState createState() => _HttpBodyState();
}

class _HttpBodyState extends State<HttpBody> {
  List<UserModal> users = [];

  void request() async {
    final result = await HttpRequest.request(
        "https://api.github.com/search/users",
        http_method: "get",
        params: {"q": "111"});

    final jsonString = json.encode(result.data["items"]);

    ///List<dynamic>
    // print(json.decode(jsonString)[0].runtimeType);

    // print(result.data["items"][0]);

    // UserModal user= UserModal.fromJson(result.data["items"][0]);

    List<dynamic> items = result.data["items"];
    setState(() {
      users = items.map((e) => UserModal.fromJson(e)).toList();
    });
    print(users);
  }

  @override
  void initState() {
    super.initState();
    request();
  }

  @override
  Widget build(BuildContext context) {
    print(users);
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].name),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(users[index].avatar),
          ),
        );
      },
    );
  }
}

class UserModal {
  final String name;
  final String avatar;

  UserModal({required this.name, required this.avatar});

  // result.data["items"]; 直接传就可以
  UserModal.fromJson(Map json)
      : name = json["login"],
        avatar = json["avatar_url"];

  @override
  String toString() {
    return 'UserModal{name: $name, avatar: $avatar}';
  }
}
