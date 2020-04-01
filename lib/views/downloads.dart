import 'dart:io';

import 'package:book_app/database/download_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epub_kitty/epub_kitty.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:uuid/uuid.dart';

class Downloads extends StatefulWidget {
  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  static const pageChannel = const EventChannel('com.maxingg.epub_kitty/page');

  bool done = true; //下载是否已完成，处理失败情况
  var db = DownloadsDB();
  static final uuid = Uuid();

  List dls = List();
  getDownloads() async {
    List l = await db.listAll();
    setState(() {
      dls.addAll(l);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDownloads();
  }

  Widget dismissItem(BuildContext context, int index) {
    Map dl = dls[index];
    return Dismissible(
      key: ObjectKey(uuid.v4),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: Icon(Feather.trash_2, color: Colors.white),
      ),
      onDismissed: (d) async {
        db.remove({"id": dl['id']}).then((v) async {
          File f = File(dl['path']);
          if (await f.exists()) f.delete();
          setState(() {
            dls.removeAt(index);
          });
        });
      },
      child: InkWell(
        onTap: () {
          String path = dl['path'];
          EpubKitty.setConfig("androidBook", "#8d6e63", "vertical", true);
          EpubKitty.open(path);

          pageChannel.receiveBroadcastStream().listen((Object event) {
            print('page:$event');
          }, onError: null);
        },
        //这里才是样式
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: <Widget>[
              //感觉这个也最好封装成组件...
              CachedNetworkImage(
                imageUrl: dl['imageUrl'],
                placeholder: (context, url) => Container(
                  height: 70,
                  width: 70,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/other/place.png",
                  fit: BoxFit.cover,
                  height: 70,
                  width: 70,
                ),
                fit: BoxFit.cover,
                height: 70,
                width: 70,
              ),

              SizedBox(
                width: 10,
              ),

              Flexible(
                child: done
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            dl['title'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "COMPLETED",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                dl['size'],
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      )
                    : Column(
                        //这个是假数据哎，感觉也可以不做，或者认真考虑下下载的错误处理
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Alice's Adventures in Wonderland",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: LinearProgressIndicator(
                              value: 0.7,
                              valueColor: AlwaysStoppedAnimation(
                                  Theme.of(context).accentColor),
                              backgroundColor: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.3),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "70%",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "300kb of 415kb",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("下载"),
      ),
      body: dls.isEmpty
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
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemBuilder: dismissItem,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemCount: dls.length),
    );
  }
}
