import 'package:flutter/material.dart';

class DrawerDemo extends StatelessWidget {
  const DrawerDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            ///如果要自定义 还是用  DrawerHeader()
            UserAccountsDrawerHeader(
              accountName: Text(
                "phoenixhell",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              accountEmail: Text("pheonixhell@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201510%2F18%2F20151018081508_jeJNL.thumb.700_0.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629104300&t=5a7d9c5be796d0aee778f9545e56f9bd"),
              ),
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201412%2F23%2F20141223225220_yxSMY.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629105690&t=be9ed671ec1e47d33a6c7e253aba55d1"),
                      fit: BoxFit.cover,
                      colorFilter:ColorFilter.mode(Colors.black12.withOpacity(0.6), BlendMode.hardLight) )),
            ),
            ListTile(
                title: Text("关闭 draw", textAlign: TextAlign.end),
                leading: Icon(Icons.workspaces_filled),

                ///标题后面设置
                trailing: Icon(Icons.wifi),

                ///关闭本层widget 和返回上一层一个意思
                onTap: () => Navigator.pop(context)),
            ListTile(
              title: Text("List Title", textAlign: TextAlign.end),
              leading: Icon(Icons.workspaces_filled),
              trailing: Icon(Icons.wifi),
            ),
            ListTile(
              title: Text("List Title", textAlign: TextAlign.end),
              leading: Icon(Icons.workspaces_filled),
              trailing: Icon(Icons.wifi),
            ),
            ListTile(
              title: Text("List Title", textAlign: TextAlign.end),
              leading: Icon(Icons.workspaces_filled),
              trailing: Icon(Icons.wifi),
            ),
          ],
        ));
  }
}
