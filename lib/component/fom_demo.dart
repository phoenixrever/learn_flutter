import 'package:flutter/material.dart';

class FormDemo extends StatefulWidget {
  const FormDemo({Key? key}) : super(key: key);

  @override
  _FormDemoState createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> {
  // final textEditingController = TextEditingController();
  final dateKey = GlobalKey<FormState>();

  String username = '';
  String password = '';

   AutovalidateMode autoValidateAfterSubmit =AutovalidateMode.disabled;

  void subFrom() {
    dateKey.currentState!.save();
    print("username: $username password: $password");
  }

  //销毁controller 资源
  @override
  void dispose() {
    super.dispose();
    // textEditingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // textEditingController.text="初始化值";
    // textEditingController
    //     .addListener(() => print("${textEditingController.text}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("form"),),
      body: Theme(
        // data: ThemeData(primaryColor: Colors.black),
        ///没有作用  以后研究
        data: Theme.of(context).copyWith(accentColor: Colors.red),
        child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: dateKey,
                  child: Column(
                    children: [
                      TextFormField(
                        ///开启第一次submit后自动验证
                        autovalidateMode:autoValidateAfterSubmit ,
                        // controller: textEditingController,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.supervised_user_circle,
                              color: Colors.white,
                            ),
                            labelText: "username",
                            labelStyle: TextStyle(color: Colors.white),
                            // filled: true,
                            ///未选中时候的颜色
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Color(0xff01efe7), width: 3.0),
                            ),

                            ///提前占好错误信息的高度
                            helperText: ''),
                        onSaved: (value) {
                          username = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty){
                            return "用户名不能为空";
                          }
                        },
                      ),
                      TextFormField(
                        autovalidateMode:autoValidateAfterSubmit,
                        //隐藏密码
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            labelText: "password",

                            ///未选中时候的颜色
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Color(0xff01efe7), width: 3.0),
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                            helperText: ''),
                        onSaved: (value) {
                          password = value!;
                        },
                        validator: (value) {
                          if (value == null || value.length == 0)
                            return "密码不能为空";
                          if (!(value.length >= 6 && value.length <= 20))
                            return "密码6到20位之间";
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            "submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              autoValidateAfterSubmit=AutovalidateMode.always;
                            });
                            if(dateKey.currentState!.validate()){
                              subFrom();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("username: $username password: $password"),

                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.greenAccent,
                            elevation: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
