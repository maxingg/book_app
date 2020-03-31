import 'package:book_app/tools/consts.dart';
import 'package:book_app/widgets/custom_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class DownloadAlert extends StatefulWidget {
  final String url; //下载地址
  final String path;

  const DownloadAlert({Key key, this.url, this.path}) : super(key: key); //存储路径

  @override
  _DownloadAlertState createState() => _DownloadAlertState();
}

class _DownloadAlertState extends State<DownloadAlert> {
  Dio dio = new Dio();
  int received = 0;
  String progress = "0";
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    download();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: CustomAlert(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "下载中...",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                //进度条
                child: LinearProgressIndicator(
                  value: double.parse(progress)/100,
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
                  backgroundColor: Theme.of(context).accentColor.withOpacity(0.3),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,    //左右对齐
                children: <Widget>[
                  Text(
                    "$progress %",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    "${Constants.formatBytes(received, 1)} "
                        "of ${Constants.formatBytes(total, 1)}",
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
      ),
      onWillPop: () => Future.value(false));
  }

  download() async {
    await dio.download(widget.url, widget.path, deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
      setState(() {
        received = receivedBytes;
        total = totalBytes;
        progress = (received / total * 100).toStringAsFixed(0); // 截取0位小数
      });
      if (receivedBytes == totalBytes) {
        Navigator.pop(context, "${Constants.formatBytes(total, 1)}");
      }
    });
  }
}
