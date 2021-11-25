import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

class SliverApp extends StatefulWidget {
  const SliverApp({Key? key}) : super(key: key);

  @override
  _SliverAppState createState() => _SliverAppState();
}

class _SliverAppState extends State<SliverApp> {
  List<Member> list = [];

  Future<void> getData() async {
    final url = "https://h5.48.cn/resource/jsonp/allmembers.php?gid=10";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw ("error");
    }
    var decode = json.decode(response.body);
    //map<Member> 返回一个 数组
    List<Member> members = decode['rows'].map<Member>((row) {
      return Member(
          id: row['sid'],
          name: row['sname'],
          team: row['tname'],
          color: row['tcolor']);
    }).toList();
    setState(() {
      list = members;
    });
  }

  List<Widget> createList() {
    Set<String> teams = HashSet();

    List<Map<String, String>> members = [];

    list.forEach((element) {
      if (!teams.contains(element.team)) {
        Map<String, String> map = {};
        map.putIfAbsent(element.team, () => element.color);
        members.add(map);
        teams.add(element.team);
      }
    });

    print(members);

    List<Widget> widgets = [];
    members.forEach((element) {
      var sliverPersistentHeader = SliverPersistentHeader(
        pinned: true,
        delegate: _MySliverPersistentHeader(
            title: element.keys.first, color: element.values.first),
      );
      widgets.add(sliverPersistentHeader);
      widgets.add(buildTeam(element.keys.first));
    });
    return widgets;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return getData();
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              title: Text("sliver app"),
              elevation: 0,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn22%2F450%2Fw800h450%2F20180413%2F519d-fzcyxmu1689038.jpg&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629254722&t=d5806257c07250077e3a24f2abef95c0",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            ///三元不能写... if 也不能加{}
            if (list.length == 0)
              SliverToBoxAdapter(
                child: LinearProgressIndicator(),
              )
            else
              ...createList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getData();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  RenderObjectWidget buildTeam(String team) {
    var members = list.where((element) => element.team == team).toList();
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          mainAxisExtent: 180,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: members[index].id,
                child: Material(
                  child: InkWell(
                    splashColor: Colors.red,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return MemberDetail(
                            heroId: members[index].id,
                            avatar: members[index].avatar,
                            name: members[index].name,
                          );
                        },
                      ));
                    },
                    // child: Container(
                    //   height: 150,
                    //   alignment: Alignment.bottomCenter,
                    //   decoration: BoxDecoration(
                    //       color: Colors.transparent,
                    //       image: DecorationImage(
                    //           image: NetworkImage(members[index].avatar),
                    //           fit: BoxFit.cover),
                    //       shape: BoxShape.circle),
                    // ),
                    child: ClipOval(
                      child: CircleAvatar(
                        child: Image.network(
                          members[index].avatar,
                          fit: BoxFit.cover,
                        ),
                        backgroundColor: Colors.white,
                        //圆圈大小
                        radius: 60,
                      ),
                    ),
                  ),
                ),
              ),
              Hero(
                  tag: members[index].avatar,
                  child: FittedBox(
                    child: Text(
                      members[index].name,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          decoration: TextDecoration.none),
                    ),
                  ))
            ],
          );
        },
        childCount: members.length,
      ),
    );
  }
}

class _MySliverPersistentHeader extends SliverPersistentHeaderDelegate {
  final String title, color;

  _MySliverPersistentHeader({
    required this.title,
    required this.color,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Color realColor = Color(int.parse(color, radix: 16) + 0xFF000000);

    return Container(
        height: 38,
        decoration: BoxDecoration(color: realColor),
        child: FittedBox(child: Text(title)));
  }

  @override

  ///最高的高度
  double get maxExtent => 38;

  @override

  ///最小的高度
  double get minExtent => 38;

  @override

  ///这边要向下转成自己定义的delegate才有自己的属性
  bool shouldRebuild(covariant _MySliverPersistentHeader oldDelegate) {
    return oldDelegate.title != title;
  }
}

class MemberDetail extends StatefulWidget {
  final String heroId, avatar, name;

  MemberDetail(
      {required this.heroId, required this.avatar, required this.name});

  @override
  _MemberDetailState createState() => _MemberDetailState();
}

class _MemberDetailState extends State<MemberDetail> {
  @override
  void initState() {
    ///hero 动画时间
    timeDilation = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black38),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black38),
                      child: Icon(
                        Icons.more_horiz,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],

            ///Don't show the leading button
            automaticallyImplyLeading: false,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.heroId,
                child: Image.network(
                  this.widget.avatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Hero(
                  tag: widget.avatar,
                  child: FittedBox(
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          decoration: TextDecoration.none),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class Member {
  final String id;
  final String name;
  final String? nickname;
  final String team;
  final String avatar;
  final String color;

  Member(
      {required this.id,
      required this.name,
      this.nickname,
      required this.team,
      required this.color})
      : avatar = "https://www.snh48.com/images/member/zp_$id.jpg";
}
