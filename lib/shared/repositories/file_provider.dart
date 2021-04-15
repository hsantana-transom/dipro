import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class FileProvider {
  final Uuid uuid = Uuid();

  // Get file path to store the file
  Future<String> generateFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/${uuid.v4().substring(0,10)}.json';
    return filePath;
  }

  // Save report as a file on the given location
  Future<void> saveFile(String filePath, Map<String, dynamic> report) async {
    File file = File(filePath);
    await file.writeAsString(jsonEncode(report));
  }

  // Read a report from a file
  Future<Map<String, dynamic>> readFile(String filePath) async {
    File file = File(filePath);
    Map<String, dynamic> report = jsonDecode(await file.readAsString());
    return report;
  }
  // Delete a file
  Future<void> deleteFile(String filePath) async {
    File file = File(filePath);
    return file.delete();
  }
}