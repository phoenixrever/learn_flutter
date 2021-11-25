import 'package:flutter/material.dart';

class FutureBuilderDemo extends StatelessWidget {
  const FutureBuilderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future:
            Future.delayed(Duration(seconds: 2), () => throw ("oops error")),
        initialData:"loading",
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                LinearProgressIndicator(),
                CircularProgressIndicator()

              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("result: ${snapshot.error}");
            }
            if (snapshot.hasData) {
              return Text("result: ${snapshot.data}");
            }
          }
          throw "something is wrong";

          ///重新按不会刷新了 但是可以得到initialData
          // if (snapshot.hasError) {
          //   return Text("result: ${snapshot.error}");
          // }
          // if (snapshot.hasData) {
          //   return Text("result: ${snapshot.data}");
          // }
          // return CircularProgressIndicator();
        },
      ),
    );
  }
}
