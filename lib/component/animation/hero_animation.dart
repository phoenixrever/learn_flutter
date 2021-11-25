import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HeroAnimationDemo extends StatelessWidget {
  const HeroAnimationDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Column(
            children: [
              ListTile(
                leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HeroDetail(),
                      ));
                    },
                    child: Hero(
                      tag: "heroKey",
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fp6.itc.cn%2Fimages03%2F20200524%2F825a43ee249f4903b3b9597e838f531b.jpeg&refer=http%3A%2F%2Fp6.itc.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629963009&t=dbaa8a01c33443d56503b2e7a37e6930"),
                      ),
                    )),
                title: Text("洪瑛琦"),
                trailing: Icon(Icons.arrow_forward_ios),
                subtitle: Text("最强童颜"),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  "最强童颜驾到!肉感胸涌丰满韩国美女洪瑛琦",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ButtonBarTheme(
                  data: ButtonBarThemeData(),
                  child: ButtonBar(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text("Like".toUpperCase()))
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}


class HeroDetail extends StatefulWidget {
  @override
  _HeroDetailState createState() => _HeroDetailState();
}

class _HeroDetailState extends State<HeroDetail> {
  @override
  void initState() {
    super.initState();
    timeDilation = 3;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              ///2个标签要一样
              tag: "heroKey",
              child: Image.network(
                "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fp6.itc.cn%2Fimages03%2F20200524%2F825a43ee249f4903b3b9597e838f531b.jpeg&refer=http%3A%2F%2Fp6.itc.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629963009&t=dbaa8a01c33443d56503b2e7a37e6930",
                fit: BoxFit.cover,
                width: 200,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "最强童颜驾到!肉感胸涌丰满韩国美女洪瑛琦",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ));
  }
}

