part of 'report_handler_bloc.dart';

enum ReportHandlerStatus { pure, initial, loading, error, success} 

class ReportHandlerState extends Equatable {
  const ReportHandlerState({this.status = ReportHandlerStatus.pure, this.report});
  
  final ReportHandlerStatus status;
  final Report report;

  @override
  List<Object> get props => [status, report];
}
