part of 'report_handler_bloc.dart';

abstract class ReportHandlerEvent extends Equatable {
  const ReportHandlerEvent();

  @override
  List<Object> get props => [];
}

class ReportHandlerAdded extends ReportHandlerEvent{
  ReportHandlerAdded(this.report);
  final Report report;

  @override
  List<Object> get props => [report];
}

class ReportHandlerSubmitted extends ReportHandlerEvent {
  ReportHandlerSubmitted(this.report, this.answer);

  final Report report;
  final Map<String,dynamic> answer;

  @override 
  List<Object> get props => [report, answer];
}
