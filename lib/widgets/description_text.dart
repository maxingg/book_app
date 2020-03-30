import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({Key key, this.text}) : super(key: key);
  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;     //控制是否展开

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length > 180) {
      firstHalf = widget.text.substring(0, 180);
      secondHalf = widget.text.substring(180, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty ? Text(
        "${firstHalf}"
          .replaceAll(r"\n", "\n")
          .replaceAll(r"\r", "")
          .replaceAll(r"\'", "'"),
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.caption.color,
        ),
      ) : Column(
        children: <Widget>[
          Text(
            "${flag ? (firstHalf + "...") : (firstHalf + secondHalf)}"
                .replaceAll(r"\n", "\n\n")
                .replaceAll(r"\r", "")
                .replaceAll(r"\'", "'"),
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),

          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  flag ? "展开" : "关闭",
                  style: TextStyle(color: Colors.teal[800],)
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          )
        ],
      )
    );
  }
}