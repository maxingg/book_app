import 'package:book_app/database/download_helper.dart';
import 'package:book_app/database/favourite_helper.dart';
import 'package:book_app/model/book.dart';
import 'package:flutter/material.dart';

//favourite key-value 对应 书名 : 整本书
class DetailsProvider extends ChangeNotifier{
  bool faved = false;
  bool downLoaded = false;

  bool loading = true;
  Book book;

  var favDB = FavouriteDB();
  var downloadDB = DownloadsDB();

  void removeFav() async{
    // favDB.remove({"id:" : });
  }

  void addFav() async {
    // await favDB.add({"id" : })
  }

  void setBook() {}

  Future<List> getDoanload() async{
    // List c = await downloadDB.check("id": )
  }

}