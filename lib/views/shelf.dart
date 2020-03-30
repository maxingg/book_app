import 'package:book_app/tools/shelfdata.dart';
import 'package:book_app/views/search_page.dart';
import 'package:flutter/material.dart';

class Shelf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 30),
        child: AppBar(
          title: SearchButton(),
          elevation: 0.0,
        ),
      ),
      body: ShelfBody(),
    );
  }
}

class ShelfBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        physics: NeverScrollableScrollPhysics(), //解决嵌套引起的不滚动问题
        children: categoryList
            .map((val) => StackCard(
                  title: val["title"],
                  imageUrl: val["imageUrl"],
                  desc: val["desc"],
                ).build(context))
            .toList(),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton.icon(
        onPressed: () {
          showSearch(context: context, delegate: searchBarDelegate());
        },
        icon: Icon(
          Icons.search,
          size: 18,
        ),
        label: Text("搜索"),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.5)),
        color: Theme.of(context).primaryColor,
        elevation: 0,
      ),
    );
  }
}

class StackCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String desc;

  const StackCard({Key key, this.title, this.imageUrl, this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/class', arguments: {
              "title": this.title,
              "desc": this.desc,
            });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              alignment: Alignment.center,
              child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    this.imageUrl,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 5,
          child: Text(
            this.title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }
}
