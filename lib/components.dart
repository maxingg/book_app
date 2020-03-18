import 'package:flutter/material.dart';

class AppBarItem extends StatefulWidget implements PreferredSizeWidget{
  String title;
  AppBarItem(this.title,);
  @override
  _AppBarItemState createState() => _AppBarItemState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0);

}

class _AppBarItemState extends State<AppBarItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: windowUtil.width,
      child: Container(
        
      ),
    );
  }
}