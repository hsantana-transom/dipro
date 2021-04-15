import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class InitDatabase {
  static Future initialize() async {
    await _initSembast();
  }

  static Future _initSembast() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "database.db");
    final database = await databaseFactoryIo.openDatabase(databasePath);
    Get.put<Database>(database);
  }
}