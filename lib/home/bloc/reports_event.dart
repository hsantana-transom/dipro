part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object> get props => [];
  
  @override 
  bool get stringify => true;
}

class ReportsReloadRequested extends ReportsEvent {
  final bool isOnline;

  ReportsReloadRequested({this.isOnline});

  @override 
  bool get stringify => true;
}

class ReportsSingleDeleteRequested extends ReportsEvent{
  final int id;

  ReportsSingleDeleteRequested(this.id);

  @override 
  bool get stringify => true;
} 

class ReportsSingleUploadRequested extends ReportsEvent{
  final Report report;
  final Map<String,dynamic> answer;

  ReportsSingleUploadRequested(this.report, this.answer);

  @override 
  bool get stringify => true;
} 

class ReportsSingleLocalUpdateRequested extends ReportsEvent{
  final Report report;
  final Map<String,dynamic> answer;

  ReportsSingleLocalUpdateRequested(this.report, this.answer);

  @override 
  bool get stringify => true;
} 

class ReportsUploadRequested extends ReportsEvent{
}

class ReportsLocalReportAdded extends ReportsEvent{
  final Map<String,dynamic> report;

  ReportsLocalReportAdded(this.report);

  @override 
  bool get stringify => true;
}
