import 'package:flutter/material.dart';

class PageViewBuilderDemo extends StatelessWidget {
  const PageViewBuilderDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 20,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              //sizebox占满所有可用空间
              SizedBox.expand(
                child: Image.network(
                  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg1.tt98.com%2Fbizhi%2F20191201%2Fec68e5c40d1900b6d43d933b310e7c38.jpg&refer=http%3A%2F%2Fimg1.tt98.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629249763&t=fe9fa67016b1e9803a5a4f39c5ca57d3",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  right:20,
                  bottom: 20,
                  child: Text(
                    "PageView.builder  第$index张",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ))
            ],
          );
        });
  }
}
