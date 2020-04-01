import 'package:book_app/model/book.dart';
import 'package:book_app/tools/dio_util.dart';
import 'package:book_app/widgets/booklist_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List searchList = <String>['红楼梦', '山月记', '万历十五年', '经济学原理'];
List defaultValue = <String>['红楼梦', '山月记'];

class searchBarDelegate extends SearchDelegate<String> {
  //搜索类型为String
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return buildSearchFutureBuilder(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final result = query.isEmpty
        ? defaultValue
        : searchList.where((value) => value.startsWith(query)).toList();

    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) => ListTile(
        title: RichText(
          //把搜索到的字符截取出来加粗
          text: TextSpan(
            text: result[index].substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            //未搜索到的内容
            children: [
              TextSpan(
                text: result[index].substring(query.length),
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder buildSearchFutureBuilder(String key) {
    return new FutureBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return new Center(
              child: new Text('Error:code '),
            );
          }
          //这里是个巨坑..data的类型是Reponse<dynamic>，为了进行迭代，必须再取里面的data才可以
          if (snapshot.data == null) return _createListView(context, null);
          return _createListView(context, snapshot.data.data);
        }
      },
      future: _getSearchData(key),
    );
  }

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Theme.of(context).primaryColor,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  Future _getSearchData(String key) async {
    var response = SharedPreferences.getInstance().then((prefs) {
      RequestOptions requestOptions = new RequestOptions(
        headers: {"token": prefs.getString("jwt")},
      );
      return DioUtil().get("/book/books/${key}", options: requestOptions);
    });
    return response;
  }

  Widget _createListView(BuildContext context, data) {
    List<Book> books = [];
    if (data != null) {
      for (var book in data) {
        books.add(Book.fromJson(book));
      }
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: BookListItem(books[index]),
          );
        },
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "res/images/other/empty.png",
            height: 300,
            width: 300,
          ),
          Text(
            "Nothing or some Errors",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class FutureBuilderPage extends StatefulWidget {
  @override
  _FutureBuilderPageState createState() => _FutureBuilderPageState();
}

class _FutureBuilderPageState extends State<FutureBuilderPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
