import 'package:flutter/material.dart';

class GridViewDemo extends StatelessWidget {
  const GridViewDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 20,
        padding: EdgeInsets.all( 10),
        ///SliverGridDelegateWithMaxCrossAxisExtent 设置宽度计算每行元素个数
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Container(
            child: Center(
                child: Text(
                  "GridView Builder $index",
                  style: TextStyle(color: Colors.white),
                )),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Finews.gtimg.com%2Fnewsapp_match%2F0%2F11674695337%2F0.jpg&refer=http%3A%2F%2Finews.gtimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629250571&t=e5d75b1ae092d6a77e4db6a651c2e5b0"),
                    fit: BoxFit.cover)),
          );
        });
  }
}
