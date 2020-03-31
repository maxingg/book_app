import 'dart:io';

import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class DownloadsDB {
  getPath() async {
    Directory docuemntDirectory = await getApplicationDocumentsDirectory();
    final path = docuemntDirectory.path + '/downloads.db';
    return path;
  }

  Future<List> check(Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    List val = await db.find(item);
    db.tidy();
    await db.close();
    return val;
  }

  add(Map map) async {
    final db = ObjectDB(await getPath());
    db.open();
    await db.insert(map);
    db.tidy();
    await db.close();
  }
}