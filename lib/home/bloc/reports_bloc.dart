import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dipro/shared/models/report.dart';
import 'package:dipro/shared/repositories/report_wrapper_repository.dart';
import 'package:equatable/equatable.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(ReportsState());

  ReportWrapperRepository reportsRepository = ReportWrapperRepository();

  @override
  Stream<ReportsState> mapEventToState(
    ReportsEvent event,
  ) async* {
    if(event is ReportsReloadRequested){
      yield* mapReportsReloadRequestedToState(event);
    } else if (event is ReportsSingleDeleteRequested){
      yield* mapReportsSingleDeleteRequestedToState(event);
    } else if (event is ReportsUploadRequested){
      yield* mapReportsUploadRequestedToState(event);
    } else if (event is ReportsLocalReportAdded){
      yield* mapReportsLocalReportAddedToState(event);
    } else if (event is ReportsSingleUploadRequested){
      yield* mapReportsSingleUploadRequestedToState(event);
    } else if (event is ReportsSingleLocalUpdateRequested){
      yield* mapReportsSingleLocalUpdateRequestedToState(event);
    }
  }

  Stream<ReportsState> mapReportsReloadRequestedToState(ReportsReloadRequested event) async*{
    yield ReportsState(status: ReportsStatus.loading);
    try{
      List<Report> reports = await reportsRepository.getAllReports();
      yield ReportsState(status: ReportsStatus.success, reports: reports);
    } catch (e) {
      yield ReportsState(status: ReportsStatus.error);
    }
  }

  Stream<ReportsState> mapReportsSingleDeleteRequestedToState(ReportsSingleDeleteRequested event) async*{
    yield ReportsState(status: ReportsStatus.loading);
    try{
      await reportsRepository.deleteLocalReport(event.id);
      List<Report> reports = await reportsRepository.getAllReports();
      yield ReportsState(status: ReportsStatus.success, reports: reports);
    } catch (e) {
      yield ReportsState(status: ReportsStatus.error);
    }
  }

  Stream<ReportsState> mapReportsLocalReportAddedToState(ReportsLocalReportAdded event) async*{
    yield ReportsState(status: ReportsStatus.loading);
    try{
      await reportsRepository.createLocalReport(event.report);
      List<Report> reports = await reportsRepository.getAllReports();
      yield ReportsState(status: ReportsStatus.success, reports: reports);
    } catch (e) {
      yield ReportsState(status: ReportsStatus.error);
    }
  }

  Stream<ReportsState> mapReportsUploadRequestedToState(ReportsUploadRequested event) async*{
    yield ReportsState(status: ReportsStatus.loading);
    try{
      List<Report> reports = await reportsRepository.getAllReports();
      yield ReportsState(status: ReportsStatus.success, reports: reports);
    } catch (e) {
      yield ReportsState(status: ReportsStatus.error);
    }
  }

  Stream<ReportsState> mapReportsSingleUploadRequestedToState(ReportsSingleUploadRequested event) async*{
    yield ReportsState(status: ReportsStatus.loading);
    try{
      await reportsRepository.uploadReport(event.report, event.answer);
      List<Report> reports = await reportsRepository.getAllReports();
      yield ReportsState(status: ReportsStatus.success, reports: reports);
    } catch (e) {
      yield ReportsState(status: ReportsStatus.error);
    }
  }

  Stream<ReportsState> mapReportsSingleLocalUpdateRequestedToState(ReportsSingleLocalUpdateRequested event) async*{
    yield ReportsState(status: ReportsStatus.loading);
    try{
      await reportsRepository.localUpdateReport(event.report, event.answer);
      List<Report> reports = await reportsRepository.getAllReports();
      yield ReportsState(status: ReportsStatus.success, reports: reports);
    } catch (e) {
      yield ReportsState(status: ReportsStatus.error);
    }
  }
}
