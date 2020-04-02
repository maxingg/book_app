import 'dart:io';
import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class FavouriteDB{
  getPath() async{
    //获取应用文档目录
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = documentDirectory.path + '/favourites.db';
    return path;
  }

  add(Map item) async{
    //创建数据库实例并打开
    final db = ObjectDB(await getPath());
    db.open(false);
    db.insert(item);
    //整理.db文件
    db.tidy();
    await db.close();
  }

  Future<int> remove(Map item) async{
    final db = ObjectDB(await getPath());
    db.open(false);
    int val = await db.remove(item);
    db.tidy();
    await db.close();
    return val;
  }

  Future<List> check(Map item) async {
    final db = ObjectDB(await getPath());
    db.open(false);
    List val = await db.find(item);
    db.tidy();
    await db.close();
    return val;
  }

  Future<List> listAll() async {
    final db = ObjectDB(await getPath());
    db.open(false);
    List val = await db.find({});
    db.tidy();
    await db.close();
    return val;
  }

  removeAll() async {
    final db = ObjectDB(await getPath());
    db.open(false);
    await db.remove({});
    db.tidy();
    await db.close();
  }

}