import 'dart:io';

import 'package:book_app/model/book.dart';
import 'package:book_app/provider/details_provider.dart';
import 'package:book_app/tools/consts.dart';
import 'package:book_app/tools/dio_util.dart';
import 'package:book_app/widgets/description_text.dart';
import 'package:book_app/widgets/download_alert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:epub_kitty/epub_kitty.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookDetails extends StatelessWidget {
  final Book book;

  static const pageChannel = const EventChannel("com.maxingg.epub_kitty/page");

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
          leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, "");
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                if (detailsProvider.faved) {
                  int code = await delFav();
                  if(code == 200)
                    detailsProvider.removeFav();
                } else {
                  var code = await addFav();
                  if(code == 201) 
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
                                      detailsProvider.getDownload().then((c) {
                                        if (c.isNotEmpty) {
                                          Map dl = c[0]; //以List存储,取第一个也是唯一一个，
                                          String path = dl["path"];
                                          EpubKitty.setConfig("androidBook",
                                              "#8d6e63", "vertical", true);
                                          EpubKitty.open(path);

                                          pageChannel
                                              .receiveBroadcastStream()
                                              .listen((Object event) {
                                            print("page:$event");
                                          }, onError: null);
                                        }
                                      });
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
                fontSize: 18,
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

  addFav() async{
    Response response = await SharedPreferences.getInstance().then((prefs) async {
      var jwt = prefs.getString("jwt");
      RequestOptions requestOptions = new RequestOptions(
        headers: {"token": jwt},
      );
      return await DioUtil().post("/fav/favs/${book.id}", options: requestOptions);
    });
    return response.statusCode;
  }

  delFav() async{
    Response response = await SharedPreferences.getInstance().then((prefs) async {
      var jwt = prefs.getString("jwt");
      RequestOptions requestOptions = new RequestOptions(
        headers: {"token": jwt},
      );
      return await DioUtil().delete("/fav/favs/${book.id}", options: requestOptions);
    });
    return response.statusCode;
  }

  downloadFile(BuildContext context, String url, String filename) async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      startDownload(context, url, filename);
    } else {
      startDownload(context, url, filename);
    }
  }

  startDownload(BuildContext context, String url, String filename) async {
    Directory appDocDir = Platform.isAndroid
        ? await getExternalCacheDirectories().then((val) {return val[0];})
        : await getApplicationSupportDirectory();
    if (Platform.isAndroid) {
      Directory(appDocDir.path.split("Android")[0] + "${Constants.appName}")
          .create(); //应用的文件目录
    }

    String path = Platform.isIOS
        ? appDocDir.path + "/$filename.epub"
        : appDocDir.path.split("Android")[0] +
            "${Constants.appName}/$filename.epub"; //真正的文件名
    File file = File(path);
    if (!await file.exists()) {
      await file.create();
    } else {
      await file.delete();
      await file.create();
    }

    showDialog(
      barrierDismissible: false, //防止对话框外部触摸时关闭
      context: context,
      builder: (context) => DownloadAlert(
        url: url,
        path: path,
      ),
    ).then((v) {
      if (v != null) {
        Provider.of<DetailsProvider>(context, listen: false).addDownload({
          "id": book.id,
          "path": path, //之后阅读时所取的地址
          "imageUrl": book.img,
          "size": v,
          "title": book.title,
        });
      }
    });
  }
}
