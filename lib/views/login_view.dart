import 'package:book_app/provider/login_provider.dart';
import 'package:book_app/widgets/loginBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child:
            provider.curWidget == 0 ? LoginView() : SignUpView(),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Stack(fit: StackFit.expand, children: <Widget>[
      BackgroundSlideMain(),
      BackgroundSlideToChange(),
      Positioned(
        left: 0,
        top: 50 * rpx,
        child: LoginBox(),
      ),
    ]);
  }
}

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Stack(fit: StackFit.expand, children: <Widget>[
      BackgroundSlideMain(),
      BackgroundSlideToChange(),
      Positioned(
        left: 0,
        top: 50 * rpx,
        child: SignUpBox(),
      ),
    ]);
  }
}

// class BackgroundImage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//       opacity: 0.6,
//       child: Image.asset(
//         "res/images/splash/splash2.jpg",
//         fit: BoxFit.cover,
//       ),
//     );
//   }
// }

class IconImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.done,
        color: Colors.white,
        size: 180,
      ),
    );
  }
}

class BackgroundSlideMain extends StatelessWidget {
  const BackgroundSlideMain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);
    return Opacity(
      opacity: provider.opacityMain,
      child: Image.asset(
        "res/images/splash/splash${provider.index}.jpg",
        fit: BoxFit.cover,
      ),
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
      child: Image.asset(
        "res/images/splash/splash${provider.indexToChange}.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
