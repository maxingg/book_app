import 'dart:ui';

import 'package:book_app/provider/login_provider.dart';
import 'package:book_app/tools/dio_util.dart';
import 'package:book_app/views/main_view.dart';
import 'package:book_app/widgets/custom_alert.dart';
import 'package:book_app/widgets/signIn_link.dart';
import 'package:book_app/widgets/signup_link.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBox extends StatefulWidget {
  @override
  _LoginBoxState createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  TextEditingController accountController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () async {
                          var username = accountController.text;
                          var password = pwdController.text;
                          if (username.length >= 4 &&
                              password.length != 0 &&
                              checkValidUserName(username)) {
                            var jwt = await attemptLogin(username, password);
                            if (jwt != null) {
                              SharedPreferences.getInstance().then((prefs) {
                                prefs.setString("jwt", jwt);
                              }); 
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: MainView(),
                                ),
                              );
                            }
                          } else {
                            displayDialog(context, "用户名或密码不合法", "");
                            accountController.text = pwdController.text = "";
                          }
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

  Future<String> attemptLogin(String username, String password) async {
    var data = {"userName": username, "passWord": password};
    Response res = await DioUtil().post('/user/user', data: data);
    if (res.statusCode == 200) {
      return res.data["token"];
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}

class SignUpBox extends StatefulWidget {
  @override
  _SignUpBoxState createState() => _SignUpBoxState();
}

class _SignUpBoxState extends State<SignUpBox> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _pwdConfirmController = TextEditingController();

  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);
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
                    controller: _accountController,
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
                    controller: _pwdController,
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
                    controller: _pwdConfirmController,
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
                      onPressed: () async {
                        var username = _accountController.text;
                        var password = _pwdController.text;
                        var passwordConfirm = _pwdConfirmController.text;
                        if (username.length < 4 ||
                            !checkValidUserName(username)) {
                          displayDialog(context, "用户名非法", "用户名过短或包含非法字符");
                          _accountController.text = "";
                        } else if (password.length == 0)
                          displayDialog(context, "密码不能为空", "");
                        else if (password != passwordConfirm) {
                          displayDialog(context, "密码不一致", "请重新输入");
                          _pwdController.text = _pwdConfirmController.text = "";
                        } else {
                          var code = await attemptSignUp(username, password);
                          if (code == 201) {
                            provider.switchLoginOrSignup();
                          } else {
                            displayDialog(context, "注册失败", "请重新来过");
                          }
                        }
                      },
                    ),
                  ))
                ],
              ),
            ),
            SignIn(),
          ],
        ),
      ),
    );
  }

  attemptSignUp(String username, String password) async {
    var data = {"userName": username, "passWord": password};
    Response result = await DioUtil().post('/user/users', data: data);
    return result.statusCode;
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
        controller: controller,
        obscureText: obsecure,
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: icon,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white)),
        style: TextStyle(fontSize: 35 * rpx, color: Colors.white),
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

void displayDialog(BuildContext context, String title, String text) =>
    showDialog(
        context: context,
        builder: (context) => CustomAlert(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 15),
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ]))));

bool checkValidUserName(String userName) {
  bool ifMatch = RegExp(r"^[ZA-ZZa-z0-9_]+$").hasMatch(userName);
  return ifMatch;
}
