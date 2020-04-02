import 'package:book_app/database/favourite_helper.dart';
import 'package:book_app/model/book.dart';
import 'package:book_app/provider/details_provider.dart';
import 'package:book_app/tools/dio_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'book_detail.dart';

class BookTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("喜欢"),
      ),
      body: TableBody(),
    );
  }
}

class TableBody extends StatefulWidget {
  @override
  _TableBodyState createState() => _TableBodyState();
}

class _TableBodyState extends State<TableBody> {
  List dls = List();
  var favdb = FavouriteDB();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    addFavDataFromCloudOrDB();
  }


  addFavDataFromCloudOrDB() {
    SharedPreferences.getInstance().then((prefs) async {
      var jwt = prefs.getString("jwt");
      RequestOptions requestOptions = new RequestOptions(
        headers: {"token": jwt},
      );
      Response response =
          await DioUtil().get("/fav/favs", options: requestOptions);
      if (response == null) {
        return null;
      }
      return response.data;
    }).then((val) async {
      List<Book> books = [];
      if (val != null) {
        for (var book in val) {
          Book b = Book.fromJson(book);
          if (dls.indexOf(b) == -1) {
            books.add(b);
          }
          List c = await favdb.check({"id": b.id});
          if(c.isEmpty)
            favdb.add({"id": book["id"].toString(), "item": book});
        }
      } else{
        getFavDataFromDB();
      }
      setState(() {
        dls.addAll(books);
      });
    });
  }

  getFavDataFromDB() async {
    List l = await favdb.listAll();
    setState(() {
      for (var sub in l) {
        if(dls.indexOf(Book.fromJson(sub["item"])) == -1)     //应付无网络环境下的情况，避免重复添加
          dls.add(Book.fromJson(sub["item"]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: dls.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    "res/images/other/empty.png",
                    height: 300,
                    width: 300,
                  ),
                  Text(
                    "Nothing is here",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                crossAxisCount: 3,
                childAspectRatio: 0.68,
              ),
              shrinkWrap: true,
              itemCount: dls.length,
              itemBuilder: _getListData,
              physics: NeverScrollableScrollPhysics(),
            ),
    );
  }

  Widget _getListData(BuildContext context, int index) {
    return BookCard(dls[index]);
  }
 
  Widget BookCard(Book book) {
    return Container(
      width: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          onTap: () {
            Provider.of<DetailsProvider>(context, listen: false).setBook(book);
            Provider.of<DetailsProvider>(context, listen: false).getFeed();
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: BookDetails(book),
                )).then((v) {
                  dls = [];
                  addFavDataFromCloudOrDB();
                });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Hero(
              tag: book.id,
              //网咯获取图片并保存至缓存
                  child: CachedNetworkImage(
                    imageUrl: "${book.img}",
                    //占位图，使用循环进度条
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "res/images/other/place.png",
                      fit: BoxFit.fitHeight,
                    ),
                    fit: BoxFit.fitHeight,
                  ),
              ),
            ),
          ),
        ),
    );
  }

}
