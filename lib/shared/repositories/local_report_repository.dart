import 'dart:io';

import 'package:dipro/shared/models/report.dart';
import 'package:dipro/shared/repositories/file_provider.dart';
import 'package:get/get.dart';
import 'package:sembast/sembast.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class LocalReportRepository {
  final Database _database = Get.find();
  final StoreRef _store = intMapStoreFactory.store("report_store");
  final FileProvider _fileProvider = FileProvider();

  Future<int> createReportSchema(Map<String, dynamic> reportSchema) async {
    assert(reportSchema != null);
    String filePath = await _fileProvider.generateFilePath();
    await _fileProvider.saveFile(filePath, reportSchema);
    return await _store.add(_database, filePath);
  }

  Future<int> updateReportSchema(
      {@required Map<String, dynamic> reportSchema,
      @required String filePath,
      @required int key}) async {
    assert(reportSchema != null);
    assert(filePath != null);
    assert(key != null);

    await _fileProvider.saveFile(filePath, reportSchema);
    final finder = Finder(filter: Filter.byKey(key));
    return await _store.update(_database, filePath, finder: finder);
  }

  Future deleteReportSchema(int reportId) async {
    assert(reportId != null);
    final snapshot = await _store.record(reportId).getSnapshot(_database);
    await _fileProvider.deleteFile(snapshot.value);
    await _store.record(reportId).delete(_database);
  }

  Future<List<Report>> getAllReports() async {
    final snapshots = await _store.find(_database);
    if (snapshots.length > 0) {
      return Future.wait(snapshots.map((snapshot) async {
        try {
          Map<String, dynamic> reportSchema =
              await _fileProvider.readFile(snapshot.value);
          reportSchema = await compute(parseReportAnswer, reportSchema);
          return Report(
              key: snapshot.key,
              filePath: snapshot.value,
              reportSchema: reportSchema,
              isOnline: false);
        } catch (e) {}
      }).toList());
    }
    return [];
  }

  Future<Report> getReportById(int reportId) async {
    final snapshot = await _store.record(reportId).getSnapshot(_database);
    Map<String, dynamic> reportSchema =
        await _fileProvider.readFile(snapshot.value);
    return Report(
        key: snapshot.key,
        filePath: snapshot.value,
        reportSchema: reportSchema);
  }
}

Future<Map<String, dynamic>> parseReportAnswer(
    Map<String, dynamic> reportSchema) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  // parse the values to their respective format
  if (reportSchema.containsKey("answer")) {
    if (reportSchema["answer"]["date"] != null) {
      reportSchema["answer"]["date"] =
          dateFormat.parse(reportSchema["answer"]["date"].substring(0, 10));
    }
    Map<String, dynamic> answer = reportSchema["answer"];
    Map<String, dynamic> newAnswer = Map<String, dynamic>();
    answer.forEach((key, value) {
      if (value.runtimeType == List<dynamic>().runtimeType ||
          value.runtimeType == List<String>().runtimeType) {
        newAnswer["$key"] = List<String>.from(value);
      } else if (key == 'photos') {
        List<String> rawPhotosStr = RegExp(r"'(.*?)'")
            .allMatches(value)
            .map((m) => m.group(0))
            .toList();
        List<File> photos = rawPhotosStr
            .map((photoStr) => File(photoStr.replaceAll(r"'", '')))
            .toList();
        newAnswer["$key"] = photos;
      } else if (value == "null") {
        // newAnswer["$key"] = null;
      } else {
        newAnswer["$key"] = value;
      }
    });
    reportSchema["answer"] = newAnswer;
  }
  return Future.value(reportSchema);
}
