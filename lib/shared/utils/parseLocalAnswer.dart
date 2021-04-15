import 'dart:io';
import 'package:intl/intl.dart';

Map<String, dynamic> parseLocalAnswer(Map<String, dynamic> rawAnswer) {
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  if (rawAnswer.containsKey("date")) {
    rawAnswer["date"] = dateFormat.parse(rawAnswer["date"].substring(0, 10));
  }
  Map<String, dynamic> answer = rawAnswer;
  Map<String, dynamic> newAnswer = Map<String, dynamic>();
  answer.forEach((key, value) {
    if (value.runtimeType == List<dynamic>().runtimeType) {
      newAnswer["$key"] = List<String>.from(value);
    } else if (key == 'photos') {
      List<String> rawPhotosStr =
          RegExp(r"'(.*?)'").allMatches(value).map((m) => m.group(0)).toList();
      List<File> photos = rawPhotosStr
          .map((photoStr) => File(photoStr.replaceAll(r"'", '')))
          .toList();
      newAnswer["$key"] = photos;
    } else if (value == "null") {
    } else {
      newAnswer["$key"] = value;
    }
  });
  rawAnswer = newAnswer;
  return rawAnswer;
}
