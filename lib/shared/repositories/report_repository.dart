import 'package:dio/dio.dart';
import 'package:dipro/shared/api/api_client.dart';
import 'package:dipro/shared/models/report.dart';
import 'package:dipro/shared/repositories/local_report_repository.dart';
import 'package:dipro/shared/repositories/online_report_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportRepository {
  final ApiClient apiClient = ApiClient();
  Dio get client => apiClient.client;
  LocalReportRepository localReportRepository = LocalReportRepository();
  OnlineReportRepository onlineReportRepository = OnlineReportRepository();

  // create an instance of the report locally
  Future<int> createReportSchema(Map<String, dynamic> reportSchema) async {
    return localReportRepository.createReportSchema(reportSchema);
  }

  // update the local report instance
  Future<int> updateLocalReport(
      {@required Map<String, dynamic> reportSchema,
      @required String filePath,
      @required int key}) async {
    // ensure parameters are not null
    assert(reportSchema != null);
    assert(filePath != null);
    assert(key != null);
    return localReportRepository.updateReportSchema(
        reportSchema: reportSchema, filePath: filePath, key: key);
  }

  // delete local report instance
  Future deleteReport(int reportId) async {
    return localReportRepository.deleteReportSchema(reportId);
  }

  // get all report
  Future<List<Report>> getAllReports() async {
    List<Report> localReports = await localReportRepository.getAllReports();
    List<Report> onlineReports = await onlineReportRepository.getAllReports();
    localReports.insertAll(localReports.length, onlineReports);
    return localReports;
  }

  // get all online reports
  Future<List<Report>> getAllOnlineReports() async {
    return onlineReportRepository.getAllReports();
  }

  // get all local reports
  Future<List<Report>> getAllLocalReports() async {
    return localReportRepository.getAllReports();
  }

  // get report by id
  Future<Report> getReportById(int reportId) async {
    return localReportRepository.getReportById(reportId);
  }

  // upload report
  Future<void> uploadReport(Report report, Map<String, dynamic> answer) async {
    await onlineReportRepository.uploadReport(report, answer);
    await localReportRepository.deleteReportSchema(report.key);
    Get.defaultDialog(
      title: "screening.report.success.label".tr,
      middleText: "screening.report.success.content.label".tr,
      textConfirm: "home.dialog.confirm-button.label".tr,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(closeOverlays: true);
      },
    );
  }

  // local update report
  Future<void> localUpdateReport(
      {@required Report report, @required Map<String, dynamic> answer}) async {
    assert(report != null);
    try {
      // initialized containers for the values to be upload
      Map<String,dynamic> parsedAnswer = await compute(parseRawAnswer, answer);
      report.reportSchema['answer'] = parsedAnswer;
      // upload the parsedValues
      await localReportRepository.updateReportSchema(
          reportSchema: report.reportSchema,
          filePath: report.filePath,
          key: report.key);
    } catch (e) {
      print(e);
    }
  }

  

  // get online report
  Future<Report> getOnlineReport(Report report) async {
    return onlineReportRepository.getReport(report);
  }

  // get online photos
  Future<List<String>> getOnlinePhotos(Report report) async {
    return onlineReportRepository.getPhotos(report);
  }
}

Future<Map<String, dynamic>> parseRawAnswer(Map<String, dynamic> answer) {
    Map<String, dynamic> parsedAnswer = Map<String, dynamic>();
    // parse the diferent values to their respective format
    answer.forEach((key, value) {
      if (value.runtimeType == DateTime(2020).runtimeType) {
        parsedAnswer['$key'] = value.toString();
      } 
      else if (key != 'photos' &&
          (value.runtimeType == List<dynamic>().runtimeType ||
              value.runtimeType == List<String>().runtimeType)) {
        parsedAnswer['$key'] = List<String>.from(value);
      } else {
        parsedAnswer['$key'] = value.toString();
      }
    });
    return Future.value(parsedAnswer);
  }
