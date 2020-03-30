import 'package:book_app/tools/book.dart';
import 'package:flutter/material.dart';

class ConcretClassPage extends StatefulWidget {
  Map arguments;

  ConcretClassPage({this.arguments});

  @override
  _ConcretClassPageState createState() =>
      _ConcretClassPageState(arguments: this.arguments);
}

class _ConcretClassPageState extends State<ConcretClassPage> {
  Map arguments;

  _ConcretClassPageState({this.arguments});

  Widget _getListData(context, index) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.2,
          child: Image.asset(
            bookList[index]["imageUrl"],
            fit: BoxFit.contain,
          ),
        ),
        Text(
          bookList[index]["title"],
          style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
          maxLines: 2,
        )
      ],
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            this.arguments["title"],
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
        ),
        preferredSize: Size.fromHeight(45),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            DescText(
              text: this.arguments["desc"],
            ),

            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 10.0,
                crossAxisCount: 3,
              ),
              shrinkWrap: true,
              itemCount: bookList.length,
              itemBuilder: _getListData,
              physics: NeverScrollableScrollPhysics(),
            )
          ],
        ),
      ),
    );
  }
}

class DescText extends StatelessWidget {
  final text;

  const DescText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              "res/images/shelf/wall.png",
              fit: BoxFit.contain,
              height: 150,
              color: Colors.green[100],
            )),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            strutStyle: StrutStyle(forceStrutHeight: true, height: 2),
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class BroadText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("精选", style: TextStyle(),),
    );
  }
}