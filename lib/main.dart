import 'dart:io';

import 'package:book_app/data/consts.dart';
import 'package:book_app/login/loginMain.dart';
import 'package:book_app/provider/app_provider.dart';
import 'package:book_app/provider/login_provider.dart';
import 'package:book_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:book_app/person/person.dart';
import 'package:book_app/shelf/shelf.dart';
import 'package:book_app/table/table.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider(),)
        // ChangeNotifierProvider(create: (_) => ShelfProvider()),
        // ChangeNotifierProvider(create: (_) => TableProvider()),
        // ChangeNotifierProvider(create: (_) => PersonProvider()),
      ],
      child: MyApp(),
    ),
    
  );
  if(Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Consumer解决重复build问题(将更新的粒度变小)
    // return Consumer<AppProvider>(
    //   builder: (BuildContext context, AppProvider appProvider, Widget child) {
    //     return MaterialApp(
    //       key: appProvider.key,
    //       debugShowCheckedModeBanner: false,
    //       navigatorKey: appProvider.navigatorKey,
    //       title: Constants.appName,
    //       theme: appProvider.theme,
    //       onGenerateRoute: onGenerateRoute,
    //       home: LoginPage(),
    //     );
    //   },
    // );
    return MaterialApp(
      title: "悦读",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      home: LoginPage(),
      theme: ThemeData(
        primaryColor: Colors.white,
        splashColor: Colors.transparent,
      ),
    );
  }
}

class MyStackPage extends StatefulWidget {
  @override
  _MyStackPageState createState() => _MyStackPageState();
}

class _MyStackPageState extends State<MyStackPage> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        selectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text("书架"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text("书案"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("我"),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(15), 
        child: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Shelf(),
          BookTable(),
          Person(),
        ],
      ),
      ),

    );
  }

}



