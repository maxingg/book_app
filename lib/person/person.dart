import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersonBody(),
    );
  }
}

class PersonBody extends StatefulWidget {
  @override
  _PersonBodyState createState() => _PersonBodyState();
}

class _PersonBodyState extends State<PersonBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("我",),
    );
  }
}