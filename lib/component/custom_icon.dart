import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://ss2.meipian.me/users/56758152/02e883a495b343bcbe09f439e6fce3eb.jpg?imageView2/2/w/750/h/1400/q/80"),
              fit: BoxFit.cover,

              ///滤镜
              colorFilter: ColorFilter.mode(
                  Colors.indigoAccent.withOpacity(0.5),
                  BlendMode.softLight))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                color: Color.fromRGBO(3, 54, 255, 1.0),
                border: Border.all(
                    color: Colors.indigoAccent,
                    width: 3.0,
                    style: BorderStyle.solid),

                ///50和下面一样是圆
                // borderRadius: BorderRadius.circular(50),
                shape: BoxShape.circle,

                ///圆心向外扩散渐变效果
                gradient: RadialGradient(
                  colors: [
                    Color.fromRGBO(7, 102, 255, 1.0),
                    Color.fromRGBO(3, 28, 128, 1.0),
                  ],
                ),
                // ///线性渐变效果 brgin end 改变起始位置
                // gradient: LinearGradient(
                //   colors: [
                //     Color.fromRGBO(7, 102, 255, 1.0),
                //     Color.fromRGBO(3, 28, 128, 1.0),
                //   ],
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter
                // ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(16, 20, 188, 1.0),
                    offset: Offset(0.0, 16.0),

                    ///阴影模糊程度
                    blurRadius: 25.0,

                    ///阴影 放大缩小 (负值)
                    spreadRadius: -9.0,
                  ),
                ]),
            child: Icon(
              Icons.pool,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
