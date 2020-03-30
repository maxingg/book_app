import 'package:book_app/model/book.dart';
import 'package:book_app/provider/details_provider.dart';
import 'package:book_app/widgets/description_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatelessWidget {
  final Book book;

  static const pageChannel = const EventChannel("com.example.epub_kitty/page");

  const BookDetails(
    this.book, {
    Key key,
  }) : super(key: key);
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
                    : Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: book.id,
                    child: CachedNetworkImage(
                      imageUrl: "${book.img}",
                      placeholder: (context, url) => Container(
                        height: 200,
                        width: 130,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                      "res/images/other/place.png",
                      fit: BoxFit.cover,
                      height: 200,
                      width: 130,
                    ),
                      fit: BoxFit.cover,
                      height: 200,
                      width: 130,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Hero(
                          tag: book.title,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              "${book.title}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Hero(
                          tag: book.author, //作者名在这里充当tag勉强了
                          child: Text(
                            "${book.author}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                            child: detailsProvider.downLoaded
                                ? FlatButton(
                                    onPressed: () {
                                      //   detailsProvider.getDoanload().then(
                                      //     if(c.isNotEmpty) {
                                      //       Map dl = c[0];

                                      //     }
                                      //   );
                                      // },
                                    },
                                    child: Text("开始阅读"))
                                : FlatButton(
                                    onPressed: () => downloadFile(
                                      context,
                                      book.link,
                                      book.title,
                                    ),
                                    child: Text("下载"),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "详情",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: Theme.of(context).textTheme.caption.color,
            ),
            SizedBox(
              height: 10,
            ),
            DescriptionTextWidget(
              text: "${book.desc}",
            ),
          ],
        ),
      );
    });
  }

  downloadFile(BuildContext context, String link, String filename) {}
}
