import 'dart:io';
import 'package:book_app/provider/app_provider.dart';
import 'package:book_app/provider/details_provider.dart';
import 'package:book_app/provider/login_provider.dart';
import 'package:book_app/routes/routes.dart';
import 'package:book_app/tools/consts.dart';
import 'package:book_app/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MyApp(),
    ),
    
  );
  //原始方案，不成熟
  // if(Platform.isAndroid) {
  //   // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
  //   SystemUiOverlayStyle systemUiOverlayStyle =
  //       SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  // }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Consumer解决重复build问题(将更新的粒度变小)
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
          theme: appProvider.theme,
          onGenerateRoute: onGenerateRoute,
          home: LoginPage(),
        );
      },
    );
    // return MaterialApp(
    //   title: "悦读",
    //   debugShowCheckedModeBanner: false,
    //   onGenerateRoute: onGenerateRoute,
    //   home: LoginPage(),
    //   theme: ThemeData(
    //     primaryColor: Colors.white,
    //     splashColor: Colors.transparent,
    //   ),
    // );
  }
}




