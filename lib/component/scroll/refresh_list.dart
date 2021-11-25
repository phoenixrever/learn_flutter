import 'package:flutter/material.dart';
import 'package:learn_flutter/network/http_request.dart';

class RefreshDemo extends StatefulWidget {
  const RefreshDemo({Key? key}) : super(key: key);

  @override
  _RefreshDemoState createState() => _RefreshDemoState();
}

class _RefreshDemoState extends State<RefreshDemo> {
  List<dynamic> _users = [];
  ScrollController _scrollController = ScrollController();

  refreshData({required String keyword}) async {

    var result =
    await HttpRequest.request("https://api.github.com/search/users?q=$keyword");
    setState(() {
      _users = result.data["items"];
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData(keyword: "ss");
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  RefreshIndicator(
      //转圈的宽度
      strokeWidth: 4.0,
      onRefresh: (){
        // return Future.delayed(Duration(seconds: 2));
        return refreshData(keyword: "phoenixrever");
      },
      child: NotificationListener(
        onNotification: (notification) {
          //获取滚动位置
          //ScrollUpdateNotification(depth: 0 (local), FixedScrollMetrics(988.5..[691.5]..0.0), scrollDelta: -0.08403042038275998)
          print(notification);
          //接着往上冒泡
          return false;
        },
        child: ListView.builder(
          itemCount: _users.length,
          //滚动过量的效果 回弹
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                NetworkImage(_users[index]["avatar_url"]),
              ),
              title: Text(_users[index]["login"]),
              trailing: Icon(Icons.arrow_forward_ios),
            );
          },
        ),
      ),
    );
  }
}
