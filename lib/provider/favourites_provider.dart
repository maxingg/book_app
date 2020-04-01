import 'package:book_app/database/favourite_helper.dart';
import 'package:flutter/cupertino.dart';

class FavouritesProvider extends ChangeNotifier {
  List posts = List();
  var db = FavouriteDB();
  
  getFeed() async {
    posts.clear();
    db.listAll().then((val) {
      posts.addAll(val);
    });
  }
}
