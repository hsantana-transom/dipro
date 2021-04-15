import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dipro/screening/screening_bloc/screening_repository.dart';
import 'package:dipro/shared/models/report.dart';
import 'package:equatable/equatable.dart';

part 'screening_event.dart';
part 'screening_state.dart';

// Screening repository that gets a report from the screening questions 
class ScreeningBloc extends Bloc<ScreeningEvent, ScreeningState> {
  ScreeningBloc() : super(ScreeningState());

  final ScreeningRepository screeningRepository = ScreeningRepository();

  @override
  Stream<ScreeningState> mapEventToState(
    ScreeningEvent event,
  ) async* {
    if(event is ScreeningResultCompleted){
      yield ScreeningState(
        report: event.report,
        serviceType: event.serviceType,
        fieldCategory: event.fieldCategory,
        status: ScreeningStatus.loading,
      );
      try{
        Report report = await screeningRepository.sendScreeningResults(
          report: state.report,
          serviceType: state.serviceType,
          fieldCategory: state.fieldCategory
        );
        yield ScreeningState(
          report: event.report,
          serviceType: event.serviceType,
          fieldCategory: event.fieldCategory,
          status: ScreeningStatus.success,
          reportInstance: report
        );
      } on DioError catch (_) {
        yield ScreeningState(
          report: event.report,
          serviceType: event.serviceType,
          fieldCategory: event.fieldCategory,
          status: ScreeningStatus.failure,
        );
      } 
    }
  }
}
