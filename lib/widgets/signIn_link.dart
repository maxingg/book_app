import 'package:book_app/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  SignIn();
  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    return (new FlatButton(
      padding: const EdgeInsets.only(
        top: 20.0,
      ),
      onPressed: () {
        loginProvider.switchLoginOrSignup();
      },
      child: new Text(
        "返回登录",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: new TextStyle(
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
            color: Colors.white,
            fontSize: 15.0),
      ),
    ));
  }
}