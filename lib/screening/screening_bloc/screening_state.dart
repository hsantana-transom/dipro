part of 'screening_bloc.dart';

enum ScreeningStatus {pure, loading, failure, success}

class ScreeningState extends Equatable {
  const ScreeningState({
    this.report,
    this.serviceType,
    this.fieldCategory,
    this.status = ScreeningStatus.pure,
    this.reportInstance
  });

  final String report;
  final String serviceType;
  final String fieldCategory;
  final ScreeningStatus status;
  final Report reportInstance;
  
  @override
  List<Object> get props => [report,serviceType,fieldCategory, status, reportInstance];
}
