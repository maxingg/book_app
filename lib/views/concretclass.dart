import 'package:book_app/model/book.dart';
import 'package:book_app/tools/dio_util.dart';
import 'package:book_app/widgets/book_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConcretClassPage extends StatefulWidget {
  Map arguments;

  ConcretClassPage({this.arguments});

  @override
  _ConcretClassPageState createState() =>
      _ConcretClassPageState(arguments: this.arguments);
}

class _ConcretClassPageState extends State<ConcretClassPage> {
  Map arguments;

  List<Book> bookItems = [];

  _ConcretClassPageState({this.arguments});

  Widget _getListData(context, index) {
    return BookCard(this.bookItems[index]);

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
            Text(
              "精选",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: Theme.of(context).textTheme.caption.color,
            ),
            SizedBox(
              height: 10,
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                crossAxisCount: 3,
                childAspectRatio: 0.68,
              ),
              shrinkWrap: true,
              itemCount: bookItems.length,
              itemBuilder: _getListData,
              physics: NeverScrollableScrollPhysics(),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      return prefs.getString("jwt");
    }).then((jwt) async {
      RequestOptions requestOptions = RequestOptions(
        headers: {"token": jwt},
      );
      Response response =
          await DioUtil().get("/book/category/${arguments["title"]}", options: requestOptions);
      if (response.statusCode == 200) return response.data;
      return null;
    }).then((val) {
      List<Book> books = [];
      if (val != null) {
        for (var book in val) books.add(Book.fromJson(book));
      }
      setState(() {
        this.bookItems = books;
      });
    });
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
      child: Text(
        "精选",
        style: TextStyle(),
      ),
    );
  }
}
