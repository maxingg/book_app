import 'dart:ui';
import 'package:book_app/provider/login_provider.dart';
import 'package:book_app/views/main_view.dart';
import 'package:book_app/widgets/signup_link.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    TextEditingController accountController = TextEditingController();
    TextEditingController pwdController = TextEditingController();
    double rpx = MediaQuery.of(context).size.width / 750;
    double margin = 60 * rpx;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5 * rpx, sigmaY: 5 * rpx),
      child: Container(
          width: 750 * rpx - 2 * margin,
          margin: EdgeInsets.symmetric(horizontal: margin),
          padding:
              EdgeInsets.symmetric(horizontal: 20 * rpx, vertical: 20 * rpx),
          child: Column(
            children: <Widget>[
              IconImage(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20 * rpx, vertical: 20 * rpx),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    LoginTextField(
                      controller: accountController,
                      obsecure: false,
                      width: 750 * rpx - 2 * margin,
                      icon: Icon(
                        Icons.face,
                        size: 40 * rpx,
                        color: Colors.white70,
                      ),
                      hintText: "请输入账号",
                    ),
                    LoginTextField(
                      controller: pwdController,
                      obsecure: true,
                      width: 750 * rpx - 2 * margin,
                      icon: Icon(
                        Icons.lock,
                        size: 40 * rpx,
                        color: Colors.white70,
                      ),
                      hintText: "请输入密码",
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30 * rpx),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20 * rpx)),
                      height: 90 * rpx,
                      // width: 750*rpx-2*margin,
                      padding: EdgeInsets.all(0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20 * rpx)),
                        color: Colors.red[500],
                        child: Text(
                          "登录",
                          style: TextStyle(
                              color: Colors.white, fontSize: 35 * rpx),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: MainView(),
                            ),
                          );
                        },
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                child: SignUp(),
              ),
            ],
          )),
    );
  }
}

class SignUpBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController accountController = TextEditingController();
    TextEditingController pwdController = TextEditingController();
    TextEditingController pwdConfirmController = TextEditingController();
    double rpx = MediaQuery.of(context).size.width / 750;
    double margin = 60 * rpx;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5 * rpx, sigmaY: 5 * rpx),
      child: Container(
        width: 750 * rpx - 2 * margin,
        margin: EdgeInsets.symmetric(horizontal: margin),
        padding: EdgeInsets.symmetric(horizontal: 20 * rpx, vertical: 20 * rpx),
        child: Column(
          children: <Widget>[
            IconImage(),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 20 * rpx, vertical: 20 * rpx),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LoginTextField(
                    controller: accountController,
                    obsecure: false,
                    width: 750 * rpx - 2 * margin,
                    icon: Icon(
                      Icons.face,
                      size: 40 * rpx,
                      color: Colors.white70,
                    ),
                    hintText: "请输入账号",
                  ),
                  LoginTextField(
                    controller: pwdController,
                    obsecure: true,
                    width: 750 * rpx - 2 * margin,
                    icon: Icon(
                      Icons.lock,
                      size: 40 * rpx,
                      color: Colors.white70,
                    ),
                    hintText: "请输入密码",
                  ),
                  LoginTextField(
                    controller: pwdConfirmController,
                    obsecure: true,
                    width: 750 * rpx - 2 * margin,
                    icon: Icon(
                      Icons.lock,
                      size: 40 * rpx,
                      color: Colors.white70,
                    ),
                    hintText: "确认密码",
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30 * rpx),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20 * rpx)),
                    height: 90 * rpx,
                    // width: 750*rpx-2*margin,
                    padding: EdgeInsets.all(0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20 * rpx)),
                      color: Colors.red[500],
                      child: Text(
                        "注册",
                        style:
                            TextStyle(color: Colors.white, fontSize: 35 * rpx),
                      ),
                      onPressed: () {
                        
                      },
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obsecure;
  final Icon icon;
  final double width;
  final String hintText;

  const LoginTextField(
      {Key key,
      this.controller,
      this.obsecure,
      this.icon,
      this.width,
      this.hintText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * rpx),
      width: width,
      child: TextField(
        obscureText: obsecure,
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: icon,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white)),
        style: TextStyle(fontSize: 35 * rpx),
      ),
    );
  }
}

class IconImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.done,
        color: Colors.white70,
        size: 300,
      ),
    );
  }
}
