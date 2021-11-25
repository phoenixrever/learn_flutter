import 'package:flutter/material.dart';
import 'package:learn_flutter/network/http_request.dart';

class GithubDemo extends StatefulWidget {
  const GithubDemo({Key? key}) : super(key: key);

  @override
  _GithubDemoState createState() => _GithubDemoState();
}

class _GithubDemoState extends State<GithubDemo> {
  List<GithubModel> githubModels = [];
  bool isConfirm = true;
  bool check = false;

  Future<void> getData() async {
    var response = await HttpRequest.request("https://api.github.com/events");
    print(response.data);
    setState(() {
      // githubModels.addAll(response.data.map<GithubModel>((l) => GithubModel(l)).toList();)
      githubModels =
          response.data.map<GithubModel>((l) => GithubModel(l)).toList();
    });
    // print(githubModels);
  }

  Future<bool> confirmDialog(index) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Warning"),
                contentPadding: EdgeInsets.all(16),
                content:
                Text("确认删除${githubModels[index].username}吗"),

                actions: [
                  Row(
                    children: [
                      Wrap(
                        spacing: 0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Checkbox(value: check, onChanged: (value) {
                            setState(() {
                              isConfirm = false;
                              check = !check;
                            });
                          }),
                          Text("不在显示")
                        ],
                      ),
                      Spacer(),
                      ElevatedButton(onPressed: () {
                        return Navigator.pop(context, false);
                      }, child: Text("取消")),
                      SizedBox(width: 10,),
                      ElevatedButton(onPressed: () {
                        return Navigator.pop(context, true);
                      }, child: Text("确认"))
                    ],
                  ),

                ],
              );
            },
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("github")),
      body: githubModels.length > 0
          ? RefreshIndicator(
        onRefresh: getData,

        ///转圈距离顶部的距离
        edgeOffset: 0.0,
       triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: githubModels.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(githubModels[index].id),
              onDismissed: (_) {
                setState(() {
                  githubModels.removeWhere(
                          (element) => element.id == githubModels[index].id);
                });
              },
              confirmDismiss: isConfirm
                  ? (direction) async{
                return await confirmDialog(index);
              }
                  : null,
              child: ListTile(
                title: Text(githubModels[index].username),
                subtitle: Text(githubModels[index].repoName),
                leading: CircleAvatar(
                  backgroundImage:
                  NetworkImage(githubModels[index].avatarUrl),
                ),
                trailing: IconButton(
                  onPressed: ()async {
                    if(await confirmDialog(index)){
                      setState(() {
                        githubModels.removeAt(index);
                      });
                    }
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          },
        ),
      )
          : Column(
        children: [LinearProgressIndicator(), Text('loading')],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // var response = await get(Uri().resolve("https://api.github.com/events"));
          // if(response.statusCode==200)
          //   print(response.body);
          // getData();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class GithubModel {
  late final String id;
  late final String username;
  late final String avatarUrl;
  late final String repoName;

  GithubModel(dynamic) {
    this.id = dynamic['id'];
    this.username = dynamic['actor']['login'];
    this.avatarUrl = dynamic['actor']['avatar_url'];
    this.repoName = dynamic['repo']['name'];
  }

  @override
  String toString() {
    return 'GithubModel{id: $id, username: $username, avatarUrl: $avatarUrl, repoName: $repoName}';
  }
}
