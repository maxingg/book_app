import 'package:book_app/database/favourite_helper.dart';
import 'package:book_app/provider/app_provider.dart';
import 'package:book_app/provider/favourites_provider.dart';
import 'package:book_app/tools/consts.dart';
import 'package:book_app/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'downloads.dart';

class Person extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "个人",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: PersonBody(),
    );
  }
}

class PersonBody extends StatefulWidget {
  @override
  _PersonBodyState createState() => _PersonBodyState();
}

class _PersonBodyState extends State<PersonBody> {
  List items = [
    {
      "icon": Feather.download,
      "title": "下载",
      "page": Downloads(),
    },
    {
      "icon": Feather.moon,
      "title": "黑夜",
    },
  ];

  Widget ListItems() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        if (items[index]["title"] == "黑夜") {
          return SwitchListTile(
            secondary: Icon(
              items[index]['icon'],
            ),
            title: Text(
              items[index]['title'],
            ),
            value:
                Provider.of<AppProvider>(context).theme == Constants.lightTheme
                    ? false
                    : true,
            onChanged: (v) {
              if (v) {
                Provider.of<AppProvider>(context, listen: false)
                    .setTheme(Constants.darkTheme, "黑夜");
              } else {
                Provider.of<AppProvider>(context, listen: false)
                    .setTheme(Constants.lightTheme, "白天");
              }
            },
          );
        }
        return ListTile(
          leading: Icon(
            items[index]['icon'],
          ),
          title: Text(
            items[index]['title'],
          ),
          onTap: () {
            Provider.of<FavouritesProvider>(context, listen: false).getFeed();
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: items[index]['page'],
                ));
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  Widget LoginOutText() {
    return GestureDetector(
      onTap: () {
        SharedPreferences.getInstance().then((prefs) {
          prefs.clear();
          FavouriteDB().removeAll();
        }).then((val) {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: LoginPage(),
            ),
          );
        });
      },
      child: Text(
        "退出当前账号",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.red[300],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListItems(),
        SizedBox(
          height: 33,
        ),
        LoginOutText(),
      ],
    );
  }
}
