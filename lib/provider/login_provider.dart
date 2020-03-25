import 'dart:async';
import 'package:flutter/material.dart';


class LoginProvider extends State<StatefulWidget>
    with ChangeNotifier, TickerProviderStateMixin {
  Animation<double> backgroundAnimation;
  AnimationController backgroundController;

  double opacityMain = 1.0;
  double opacityToChange = 0.0;

  int index = 0; //当前看到图片的编号
  int indexToChange = 1;

  int curWidget = 0;

  //图片列表
  List<String> imgList;
  Timer interval;

  LoginProvider() {
    curWidget = 0;
    
    imgList = List<String>();
    imgList.add("res/images/splash/splash0.jpg");
    imgList.add("res/images/splash/splash1.jpg");
    imgList.add("res/images/splash/splash2.jpg");
    imgList.add("res/images/splash/splash3.jpg");
    backgroundController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    backgroundAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(backgroundController)
          ..addListener(() {
            opacityMain = 1.0 - backgroundAnimation.value;
            opacityToChange = backgroundAnimation.value;
            notifyListeners();
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              index = index + 1;
              indexToChange = indexToChange + 1;
              if (index == imgList.length) {
                index = 0;
              }

              if (indexToChange == imgList.length) {
                indexToChange = 0;
              }
              opacityMain = 1.0;
              opacityToChange = 0.0;
              notifyListeners();
            }
          });

    interval = Timer.periodic(Duration(seconds: 5), (callback) {
      backgroundController.forward(from: 0);
    });
  }

  //切换注册或登录组件
  switchLoginOrSignup() {
    curWidget = curWidget == 0 ? 1 : 0;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    interval.cancel();
    backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
