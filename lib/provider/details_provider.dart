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

  getFeed() async {
    checkFav();
    checkDownload();
  }

  void removeFav() async{
    // favDB.remove({"id:" : });
    favDB.remove({"id": book.id}).then((v) {
      print(v);
      checkFav();
    });
  }

  void addFav() async {
    // await favDB.add({"id" : })
    await favDB.add({"id": book.id, "item": book.toJson()});
    checkFav();
  }

  void setBook(val) {
    book = val;
    notifyListeners();
  }

  void checkFav() async{
    List c = await favDB.check({"id": book.id});
    if(c.isNotEmpty) {
      setFaved(true);
    } else {
      setFaved(false);
    }
  }

  Future<void> checkDownload() async {
    List c= await downloadDB.check({"id": book.id});
    if(c.isNotEmpty) {
      setDownloaded(true);
    } else {
      setDownloaded(false);
    }
  }

  void setFaved(bool param) {
    faved = param;
    notifyListeners();
  }

  void setDownloaded(bool param) {
    downLoaded = param;
    notifyListeners();
  }

  Future<List> getDownload() async {
    List c = await downloadDB.check({"id": book.id});
    return c;
  }

   addDownload(Map map) async {
    await downloadDB.add(map);
    checkDownload();
  }

}