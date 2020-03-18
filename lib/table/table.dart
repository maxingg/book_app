import 'package:flutter/material.dart';

class BookTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableBody(),
    );
  }
}

class TableBody extends StatefulWidget {
  @override
  _TableBodyState createState() => _TableBodyState();
}

class _TableBodyState extends State<TableBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("书桌"),
    );
  }
}