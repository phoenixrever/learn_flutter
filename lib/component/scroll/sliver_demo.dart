import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "dart:math";

class SliverDemo extends StatefulWidget {
   SliverDemo({Key? key}) : super(key: key);

  @override
  _SliverDemoState createState() => _SliverDemoState();
}

class _SliverDemoState extends State<SliverDemo> {
  FocusNode _textFieldFocus = FocusNode();
  Color _color = Colors.grey.withOpacity(0.6);
  //todo 更具constainet 滑动的距离 改变textfeild的大小
  double _with=100;

  @override
  void initState() {
    _textFieldFocus.addListener((){
      if(_textFieldFocus.hasFocus){
        setState(() {
          _color = Colors.white.withOpacity(0.6);
          _with=200;
        });
      }else{
        setState(() {
          _color = Colors.grey.withOpacity(0.6);
          _with=100;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(title: Text("title"),),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.headline6!,
        child: CustomScrollView(
          ///stretchModes 这个下面才有用
          physics: BouncingScrollPhysics(),

          slivers: [
            SliverAppBar(
              /// 一直出现
              pinned: true,

              ///回滚的时候稍微滚下appbar会出现
              // floating: true,
              ///配套 floating 玩下拉一点出一点  snap直接全部出现
              ///晚上滚也会直接消失
              // snap: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedContainer(
                    height: 30,
                    width:_with,
                    // color: Colors.red,
                    duration: Duration(milliseconds: 3000),
                    child: TextField(
                      focusNode: _textFieldFocus,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: _color,

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.blue.withOpacity(0.3),
              // elevation: 0.0,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios)),
              expandedHeight: 200,
              actions: [
                Icon(Icons.more_horiz),
                SizedBox(
                  width: 20,
                )
              ],

              ///配合stretchModes 使用 允许向下拉升
              stretch: true,

              flexibleSpace: FlexibleSpaceBar(
                ///如果对title不满意可以自定义 一般不需要
                // titlePadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                // title: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "stand",
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.w600,
                //           letterSpacing: 3.0),
                //     ),
                //   ],
                // ),
                title: Text("sliver app"),
                centerTitle: true,

                ///需要前置条件  stretch: true,physics:BouncingScrollPhysics() ,
                stretchModes: [
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle
                ],

                ///缩回去的效果m默认parallax
                collapseMode: CollapseMode.pin,

                background: Image.network(
                  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn22%2F450%2Fw800h450%2F20180413%2F519d-fzcyxmu1689038.jpg&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629254722&t=d5806257c07250077e3a24f2abef95c0",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            ///转化普通renderbox组件为sliver组件
            SliverAnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: 1,
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("SliverToBoxAdapter 转化普通renderbox组件为sliver组件"),
                ),
              ),
            ),

            ///原型是看不见的 只是设置一个模板高度 其他组件都用这个高度
            SliverPrototypeExtentList(
              prototypeItem: Text("prototypeItem"),
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  color: Colors.primaries[index % 18],
                  child: Text("SliverPrototypeExtentList $index"),
                );
              }, childCount: 10),
            ),

            ///占满真整个视窗 相当于pageview
            SliverFillViewport(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                color: Colors.primaries[index],
                child: Center(child: Text("SliverFillViewport $index")),
              );
            }, childCount: 3)),

            SliverPadding(
              padding: EdgeInsets.all(10),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      height: 100,
                      color: Colors.primaries[index],
                    );
                  },
                  childCount: 10,
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
                          onTap: () {},
                          child: Container(
                            child: Stack(children: [
                              Positioned(
                                  top: 20,
                                  left: 10,
                                  child: Text("gird view  Ink Inkwell $index")),
                            ]),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: 10,
                ),
              ),
            ),

            ///构建
          ],
        ),
      ),
    );
  }
}
