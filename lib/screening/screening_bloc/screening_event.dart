part of 'screening_bloc.dart';

abstract class ScreeningEvent extends Equatable {
  const ScreeningEvent();

  @override
  List<Object> get props => [];
}

class ScreeningResultCompleted extends ScreeningEvent {
  const ScreeningResultCompleted(
      {this.report, this.fieldCategory, this.serviceType});

  final String report;
  final String serviceType;
  final String fieldCategory;

  @override 
  List<String> get props => [report, fieldCategory, serviceType];
}

