part of 'reports_bloc.dart';


enum ReportsStatus { pure, loading, error, success}

class ReportsState extends Equatable {
  const ReportsState({this.reports = const [], this.status = ReportsStatus.pure});
  final ReportsStatus status;
  final List<Report> reports;

  ReportsState copyWith({
    ReportsStatus status,
    List<Report> reports,
  }){
    return ReportsState(
      status: status ?? this.status,
      reports: reports ?? this.reports
    );
  }
  
  @override
  List<Object> get props => [reports, status];

  @override 
  bool get stringify => true;
}
