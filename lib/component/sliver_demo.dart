import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "dart:math";

class SliverDemo extends StatelessWidget {
  const SliverDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 10,
            leading: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios)),
            // title: Center(child: Text("sliver")),
            expandedHeight: 200,
            // actions: [
            //   Icon(Icons.more_horiz),
            //   SizedBox(
            //     width: 20,
            //   )
            // ],
            snap: false,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(horizontal:0,vertical:15),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "stand",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3.0),
                  ),
                ],
              ),
              background: Image.network(
                "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn22%2F450%2Fw800h450%2F20180413%2F519d-fzcyxmu1689038.jpg&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629254722&t=d5806257c07250077e3a24f2abef95c0",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid(
              ///grid模板 list不需要
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,

                  ///放大 缩小
                  childAspectRatio: 1.0),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Material(
                    borderRadius: BorderRadius.circular(12.0),
                    elevation: 14.0,
                    // shadowColor: Colors.grey.withOpacity(0.8),
                    child: Ink(
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(
                              Random().nextInt(256),
                              Random().nextInt(256),
                              Random().nextInt(256),
                              1.0),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: InkWell(
                        onTap: (){

                        },
                        child: Container(
                          child: Stack(children: [
                            Positioned(
                                top: 20, left: 10, child: Text("gird view $index")),
                          ]),
                        ),
                      ),
                    ),
                  );
                },
                childCount: 50,
              ),
            ),
          ),

          ///构建
        ],
      ),
    );
  }
}
