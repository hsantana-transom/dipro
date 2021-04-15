import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dipro/shared/api/api_client.dart';
import 'package:dipro/shared/models/report.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as Get;
import 'package:intl/intl.dart';

class OnlineReportRepository {
  final ApiClient apiClient = ApiClient();
  Dio get client => apiClient.client;

  // get all online reports
  Future<List<Report>> getAllReports() async {
    try {
      // request all online reports
      Response response = await client.get('/formulary/all');
      Map<String, dynamic> rawResponse = await response.data;
      // parse the data to a raw json list
      List<Map<String, dynamic>> rawReportList =
          List<Map<String, dynamic>>.from(rawResponse["data"]);
      // parse the data to a simple report model
      List<Report> reportList = rawReportList.map((rawReport) {
        return Report(isOnline: true, key: rawReport["id"]);
      }).toList();
      return reportList;
    } catch (e) {
      return [];
    }
  }

  // parse and upload a report
  Future<void> uploadReport(Report report, Map<String, dynamic> answer) async {
    try {
      // initialized containers for the values to be upload
      Map<String, dynamic> parsedAnswer = Map<String, dynamic>();
      List<File> photos;
      // parse the diferent values to their respective format
      print("Answer $answer");
      answer.forEach((key, value) {
        if (value.runtimeType == DateTime(2020).runtimeType) {
          parsedAnswer['$key'] = value.toString();
        } else if (key == 'photos') {
          photos = List<File>.from(value);
        } else if (key != 'photos' &&
            (value.runtimeType == List<dynamic>().runtimeType ||
                value.runtimeType == List<String>().runtimeType)) {
          parsedAnswer['$key'] = List<String>.from(value);
        } else {
          parsedAnswer['$key'] = value;
        }
      });
      // upload the parsedValues
      if(parsedAnswer.containsKey('answers')){
        parsedAnswer = parsedAnswer["answers"];
      }
      await _uploadReport(
          parsedAnswer, report.reportSchema["service_type"], photos);
    } catch (e) {
      print(e);
    }
  }

  // parse photos
  Future<void> _uploadReport(
      Map<String, dynamic> answer, String formName, List<File> photos) async {
    // Initialized values to parse the request
    Map<String, dynamic> parsedPhotos = Map<String, dynamic>();
    int i = 1;
    // Parse the photos to multipart files
    await Future.forEach(photos, (photo) async {
      String fileName = photo.path.split('/').last;
      parsedPhotos['photo$i'] =
          await MultipartFile.fromFile(photo.path, filename: fileName);
      i++;
    });
    // raw data before being sent
    Map<String, dynamic> rawData = {
      "answer": answer,
      "form_name": formName,
      "locale": Get.Get.locale.languageCode,
    };
    rawData.addAll(parsedPhotos);
    // cast the rawData to a form data
    FormData data = FormData.fromMap(rawData);
    await client.post("/formulary/store", data: data);
  }

  // get online report
  Future<Report> getReport(Report report) async {
    // get the raw online report
    Response response =
        await client.get("/formulary/show/${report.key.toString()}");
    Map<String, dynamic> rawReport = response.data;
    //parse the data string to a DateTime
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    if (rawReport["answer"]["date"] != null) {
      rawReport["answer"]["date"] =
          dateFormat.parse(rawReport["answer"]["date"].substring(0, 10));
    }
    Map<String, dynamic> newAnswer =
        await compute(parseRawOnlineReport, rawReport);
    rawReport["answer"] = newAnswer;
    rawReport = await compute(appendValueToFields, rawReport);
    Report reportInstance = report.copyWith(reportSchema: rawReport);
    return reportInstance;
  }

  // get photos
  Future<List<String>> getPhotos(Report report) async {
    Response response =
        await client.get("/formulary/images/${report.key.toString()}");
    Map<String, dynamic> data = response.data;
    return List<String>.from(data["photos"]);
  }
}

//Parsed the online report to the required format
Future<Map<String, dynamic>> parseRawOnlineReport(
    Map<String, dynamic> rawReport) async {
  // parse the values to their respective format
  Map<String, dynamic> answer = rawReport["answer"];
  Map<String, dynamic> newAnswer = Map<String, dynamic>();
  answer.forEach((key, value) {
    if (value.runtimeType == List<dynamic>().runtimeType) {
      newAnswer["$key"] = List<String>.from(value);
    } else {
      newAnswer["$key"] = value;
    }
  });
  return Future.value(newAnswer);
}

// Append the answer field to the reportSchema
Future<Map<String, dynamic>> appendValueToFields(
    Map<String, dynamic> report) async {
  (List<Map<String, dynamic>>.from(report["es"])).forEach((field) {
    if (field["name"] != "date") {
      if (report["answer"][field["name"]].runtimeType ==
              List<dynamic>().runtimeType ||
          report["answer"][field["name"]].runtimeType ==
              List<String>().runtimeType) {
        field['value'] = List<String>.from(report["answer"][field["name"]]);
      } else {
        field['value'] = report["answer"][field["name"]];
      }
      if (field.containsKey('expandedFields')) {
        (List<Map<String, dynamic>>.from(field["expandedFields"])).forEach(
          (subfield) {
            if (report["answer"][subfield["name"]].runtimeType ==
                    List<dynamic>().runtimeType ||
                report["answer"][subfield["name"]].runtimeType ==
                    List<String>().runtimeType) {
              subfield['value'] =
                  List<String>.from(report["answer"][subfield["name"]]);
            } else {
              subfield['value'] = report["answer"][subfield["name"]];
            }
          },
        );
      }
    }
  });
  (List<Map<String, dynamic>>.from(report["pt"])).forEach((field) {
    if (field["name"] != "date") {
      if (report["answer"][field["name"]].runtimeType ==
              List<dynamic>().runtimeType ||
          report["answer"][field["name"]].runtimeType ==
              List<String>().runtimeType) {
        field['value'] = List<String>.from(report["answer"][field["name"]]);
      } else {
        field['value'] = report["answer"][field["name"]];
      }
      if (field.containsKey('expandedFields')) {
        (List<Map<String, dynamic>>.from(field["expandedFields"])).forEach(
          (subfield) {
            if (report["answer"][subfield["name"]].runtimeType ==
                    List<dynamic>().runtimeType ||
                report["answer"][subfield["name"]].runtimeType ==
                    List<String>().runtimeType) {
              subfield['value'] =
                  List<String>.from(report["answer"][subfield["name"]]);
            } else {
              subfield['value'] = report["answer"][subfield["name"]];
            }
          },
        );
      }
    }
  });
  return Future.value(report);
}
