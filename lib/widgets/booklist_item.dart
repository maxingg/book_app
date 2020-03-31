import 'package:book_app/model/book.dart';
import 'package:book_app/provider/details_provider.dart';
import 'package:book_app/views/book_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class BookListItem extends StatelessWidget {
  final Book book;
 
  BookListItem(this.book);

  @override
  Widget build(BuildContext context) {
    DetailsProvider detailsProvider = Provider.of<DetailsProvider>(context);
    return InkWell(
      onTap: () {
        detailsProvider.setBook(book);
        detailsProvider.getFeed();
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: BookDetails(this.book),
            ));
      },
      child: Container(
        height: 150,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //图书的卡片展示
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Hero(
                  tag: book.id,
                  child: CachedNetworkImage(
                    imageUrl: "${book.img}",
                    placeholder: (context, url) => Container(
                      height: 150,
                      width: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "res/images/other/place.png",
                      fit: BoxFit.cover,
                      height: 150,
                      width: 100,
                    ),
                    fit: BoxFit.cover,
                    height: 150,
                    width: 100,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: book.title,
                    child: Material(
                      type: MaterialType.transparency, //对话框外半透明效果
                      child: Text(
                        "${book.title}",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.title.color,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Hero(
                    tag: book.author,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        "${book.author}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    //进行截取
                    "${book.desc.length < 70 ? book.desc : book.desc.substring(0, 70)}..."
                        .replaceAll(r"\n", "\n\n")
                        .replaceAll(r"\r", "")
                        .replaceAll(r"\'", "'"),
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
