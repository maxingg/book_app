import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DownloadsDB {
  getPath() async {
    Directory docuemntDirectory = await getApplicationDocumentsDirectory();
    final path = docuemntDirectory.path + '/downloads.db';
    return path;
  }
}