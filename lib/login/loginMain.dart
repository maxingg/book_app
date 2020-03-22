import 'package:book_app/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BackgroundSlideMain(),
          BackgroundSlideToChange(),
        ],
      ),
    );
  }
}

class BackgroundSlideMain extends StatelessWidget {
  const BackgroundSlideMain({Key key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);
    return Opacity(
      opacity: provider.opacityMain,
      child: Image.asset("res/images/splash/splash${provider.index}.jpg", fit: BoxFit.cover,),
    );
  }
}

class BackgroundSlideToChange extends StatelessWidget {
  const BackgroundSlideToChange({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);
    return Opacity(
      opacity: provider.opacityToChange,
      child: Image.asset("res/images/splash/splash${provider.indexToChange}.jpg", fit: BoxFit.cover,),
    );
  }
}