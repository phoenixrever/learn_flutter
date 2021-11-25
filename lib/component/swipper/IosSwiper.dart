import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:learn_flutter/component/button/pop_menu_button.dart';
import 'package:learn_flutter/component/title_divider.dart';

class IosSwiper extends StatefulWidget {
  const IosSwiper({Key? key}) : super(key: key);

  @override
  _IosSwiperState createState() => _IosSwiperState();
}

class _IosSwiperState extends State<IosSwiper> {
  final List<String> images = [
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F00.minipic.eastday.com%2F20170504%2F20170504175607_4d027b56b1f97dd728228c0f75b73af5_2.jpeg&refer=http%3A%2F%2F00.minipic.eastday.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629943061&t=761501af9ef9e7958befde5baa3b6924",
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F00.minipic.eastday.com%2F20170509%2F20170509200320_7dacf48b2bcc4b4ab7a0412b333ccb99_7.jpeg&refer=http%3A%2F%2F00.minipic.eastday.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629943061&t=8fc86f73fffe300ddfb3640d4a039da5",
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage.xcar.com.cn%2Fattachments%2Fa%2Fday_120131%2F2012013111_5b243ef142aa4bd4293dStgzwibSw4me.jpg&refer=http%3A%2F%2Fimage.xcar.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629943407&t=44f3225b554345da1e69f7e45f2aeab5",
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("ios swiper"),
          automaticallyImplyLeading: true,
          automaticallyImplyMiddle: true,
        ),
        child: ListView(
          children: [
            Container(
              height: 400,
              child: Swiper(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
                pagination: SwiperPagination(),//轮播图指示点
                control: SwiperControl(),//左右箭头
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 400,
              child: Swiper(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
                viewportFraction: 0.7,//主图的显示比例
                scale: 0.7,//两边的图的缩小比例
              ),
            ),
            SizedBox(height: 30,),
            Text("SwiperLayout.TINDER,",style: TextStyle(fontSize: 15),),
            Container(
              height: 200,
              child: Swiper(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
                itemWidth: 300,
                layout: SwiperLayout.TINDER,
              ),
            ),
            SizedBox(height: 30,),
            Text(" SwiperLayout.STACK",style: TextStyle(fontSize: 15),),
            Container(
              height: 200,
              child: Swiper(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
                itemWidth: 300,
                layout: SwiperLayout.STACK,
              ),
            )
          ],
        ),
      resizeToAvoidBottomInset:true ,
    );
  }
}
