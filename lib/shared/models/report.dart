import 'package:dipro/shared/utils/parseLocalAnswer.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Report extends Equatable {
  Map<String, dynamic> reportSchema;
  String filePath;
  int key;
  bool isOnline;
  List<String> photos;

  Report({
    this.reportSchema,
    this.filePath,
    this.key,
    this.isOnline,
    this.photos,
  });

  Report copyWith({
    Map<String, dynamic> reportSchema,
    String filePath,
    int key,
    bool isOnline,
    List<String> photos,
  }) {
    return Report(
        reportSchema: reportSchema ?? this.reportSchema,
        filePath: filePath ?? this.filePath,
        key: key ?? this.key,
        isOnline: isOnline ?? this.isOnline,
        photos: photos ?? this.photos);
  }

  Report.fromLocalSnapshot(
      {this.key, this.filePath, Map<String, dynamic> rawReport}) {
    if (rawReport.containsKey("answer")) {
      rawReport["answer"] = parseLocalAnswer(rawReport["answer"]);
      this.reportSchema = rawReport;
    } else {
      this.reportSchema = rawReport;
    }
    this.isOnline = false;
  }

  @override
  List<Object> get props => [reportSchema, filePath, key, isOnline, photos];
}
