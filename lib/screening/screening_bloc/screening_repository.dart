import 'package:dio/dio.dart';
import 'package:dipro/home/bloc/reports_bloc.dart';
import 'package:dipro/shared/api/api_client.dart';
import 'package:dipro/shared/models/report.dart';
import 'package:dipro/shared/repositories/report_repository.dart';
import 'package:get/get.dart' as Get;

class ScreeningRepository {
  ApiClient _apiClient = ApiClient();
  Dio get client => _apiClient.client;
  ReportRepository reportRepository = ReportRepository();
  // Send the answers of the screening process
  Future<Report> sendScreeningResults(
      {String report, String serviceType, String fieldCategory}) async {
    Response response = await client.post('/formulary/kind', data: {
      'report': report,
      'service_type': serviceType,
      'field_category': fieldCategory,
    });
    int reportId = await reportRepository.createReportSchema(response.data);
    Report reportObj = await reportRepository.getReportById(reportId);
    // ignore: close_sinks
    ReportsBloc reportsBloc = Get.Get.find();
    reportsBloc.add(ReportsReloadRequested());
    return reportObj;
  }
}
