import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dipro/shared/models/report.dart';
import 'package:dipro/shared/repositories/report_repository.dart';
import 'package:equatable/equatable.dart';

part 'report_handler_event.dart';
part 'report_handler_state.dart';

// ReportHandlerBloc thats get an online report and parses the data for the view
class ReportHandlerBloc extends Bloc<ReportHandlerEvent, ReportHandlerState> {
  ReportHandlerBloc() : super(ReportHandlerState());

  final ReportRepository reportRepository = ReportRepository();

  @override
  Stream<ReportHandlerState> mapEventToState(
    ReportHandlerEvent event,
  ) async* {
    if (event is ReportHandlerAdded) {
      if (event.report.isOnline == true) {
        Report report = await reportRepository.getOnlineReport(event.report);
        List<String> photos =
            await reportRepository.getOnlinePhotos(event.report);
        Report reportWithPhotos = report.copyWith(photos: photos);
        yield ReportHandlerState(
          status: ReportHandlerStatus.initial,
          report: reportWithPhotos,
        );
      } else {
        yield ReportHandlerState(
          status: ReportHandlerStatus.initial,
          report: event.report,
        );
      }
    } else if (event is ReportHandlerSubmitted) {
      yield ReportHandlerState(
        status: ReportHandlerStatus.loading,
        report: event.report,
      );
      try {
        await reportRepository.uploadReport(
          event.report,
          event.answer,
        );
        yield ReportHandlerState(
          status: ReportHandlerStatus.success,
          report: event.report,
        );
      } catch (e) {
        yield ReportHandlerState(
          status: ReportHandlerStatus.error,
          report: event.report,
        );
      }
    }
  }
}
