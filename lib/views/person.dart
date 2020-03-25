import 'package:book_app/provider/app_provider.dart';
import 'package:book_app/tools/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

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
      "icon": Feather.heart,
      "title": "下载",
      "page": Downloads(),
    },
    {
      "icon": Feather.moon,
      "title": "黑夜",
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
                  ? false
                  : true,
              onChanged: (v){
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
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}
