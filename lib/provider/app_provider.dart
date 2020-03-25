import 'package:book_app/tools/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    checkTheme();
  }

  ThemeData theme = Constants.lightTheme;
  //Key --- 在Widget树中保存状态
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }

  void setTheme(value, c) {
    theme = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("theme", c).then((val) {
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);  //恢复顶部状态栏
        
        //沉浸式状态栏
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          // statusBarColor: c == "dark" ? Constants.darkPrimary : Constants.lightPrimary,
          statusBarIconBrightness: c == "黑夜" ? Brightness.light: Brightness.dark,
          statusBarColor: Colors.transparent,
        ));
      });
    });
    notifyListeners();
  }

  ThemeData getTheme(value) {
    return theme;
  }

  Future<ThemeData> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData t;
    String r = prefs.getString("theme") == null ? "白天" : prefs.getString("theme");
    if(r == "白天") {
      t = Constants.lightTheme;
      setTheme(Constants.lightTheme, "白天");
    }else {
      t = Constants.darkTheme;
      setTheme(Constants.darkTheme, "黑夜");
    }

    return t;
  }
}