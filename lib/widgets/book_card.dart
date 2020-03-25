import 'package:book_app/provider/details_provider.dart';
import 'package:book_app/views/book_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:objectdb/objectdb.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final String id; //充当tag
  final String img; //封面
  final String title; //标题
  final String author; //作者
  final String category; //所属类别
  final String desc; //描述

  const BookCard(
      {Key key,
      this.img,
      this.title,
      this.author,
      this.category,
      this.desc,
      this.id})
      : super(key: key); //作者

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(10),
        )),
        elevation: 5,
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          onTap: () {
            Provider.of<DetailsProvider>(context, listen: false).setBook();
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: BookDetails(
                    img: this.img,
                    title: this.title,
                    author: this.author,
                    category: this.category,
                    desc: this.desc,
                  ),
                ));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Hero(
              tag: id,
              //网咯获取图片并保存至缓存
              child: CachedNetworkImage(
                imageUrl: "$img",
                //占位图，使用循环进度条
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "res/images/other/place.png",
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
