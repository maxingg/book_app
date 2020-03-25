import 'package:book_app/provider/details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatelessWidget {
  final String img;
  final String title;
  final String author;
  final String category;
  final String desc;

  const BookDetails(
      {Key key, this.img, this.title, this.author, this.category, this.desc})
      : super(key: key);

  static const pageChannel = const EventChannel("com.example.epub_kitty/page");
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsProvider>(builder:
        (BuildContext context, DetailsProvider detailsProvider, Widget child) {
      return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                if (detailsProvider.faved) {
                  detailsProvider.removeFav();
                } else {
                  detailsProvider.addFav();
                }
              },
              icon: Icon(
                detailsProvider.faved ? Icons.favorite : Feather.heart,
                color: detailsProvider.faved
                    ? Colors.red
                    : Theme.of(context).iconTheme,
              ),
            )
          ],
        ),
        body: ListView(),
      );
    });
  }
}
