import 'dart:async';

import 'package:book_app/tools/consts.dart';
import 'package:book_app/tools/dio_util.dart';
import 'package:book_app/views/login_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_view.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var timeout = const Duration(seconds: 2);
  var ms = const Duration(milliseconds: 1);

  bool res = false;   //默认进入登录

  startTimeout() {
    return new Timer(Duration(seconds: 2), handleTimeout,);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: res == true ? MainView() : LoginPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loginOrEnterDirectly();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
//        mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Feather.book_open,
              color: Theme.of(context).accentColor,
              size: 70,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${Constants.appName}",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginOrEnterDirectly() async {
    SharedPreferences.getInstance().then((prefs) {
      return prefs.getString("jwt");
    }).then((String jwt) async {
      // print(jwt);
      RequestOptions requestOptions = RequestOptions(
        headers: {
          "token": jwt,
        }, 
      );
      Response response =
        await DioUtil().get("/user/message", options: requestOptions);
      if(response.statusCode == 200)
        res = true;  //直接进入登录页面
    }).whenComplete(() => {});
    res = false;   //进行登录
  }
}
