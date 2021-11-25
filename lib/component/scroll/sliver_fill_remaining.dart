import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverFillRemainingDemo extends StatelessWidget {
  const SliverFillRemainingDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text("sliver-fill-remaining"),
              background: Image.network(
                "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn22%2F450%2Fw800h450%2F20180413%2F519d-fzcyxmu1689038.jpg&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629254722&t=d5806257c07250077e3a24f2abef95c0",
                fit: BoxFit.cover,
              ),
            ),
          ),


          SliverList(
              delegate: SliverChildListDelegate([
            FlutterLogo(size: 100),
            FlutterLogo(size: 100),
            FlutterLogo(size: 100),
          ])),
          SliverToBoxAdapter(
            child: Divider(
              thickness: 4,
            ),
          ),

          ///sliver 剩下的部分 永远占据剩余
          SliverFillRemaining(
            // child: Slider(value: 0.5, onChanged: (double value) {}),
            child:Center(child: FlutterLogo(size: 100,)),
          ),



          ///constraints  监听整个sliver scroll的内容:
          ///AxisDirection.down  方向往下滚的sliver
          ///GrowthDirection.forward  下一个元素排列的地方 down的前方 就行down的下面
          ///ScrollDirection.reverse  forward 为down的正方向  reverse 为反方向(在这里就是向上滚)
          ///scrollOffset: 0.0  已经往正方向滚出去的距离  在这里为0 (没有滚动)
          ///remainingPaintExtent: 780.0 此layout减去前面的内容 这个screen 还能有多少剩余空间(往下)可以画
          ///viewportMainAxisExtent 总高度
          ///remainingCacheExtent 屏幕外缓存 
          SliverLayoutBuilder(builder: (BuildContext context, SliverConstraints constraints) {
            print(constraints);
            return SliverToBoxAdapter(
            );
          },),



          SliverToBoxAdapter(
            child: Placeholder(fallbackHeight: 2000,),
          )
        ],
      ),
    );
  }
}
