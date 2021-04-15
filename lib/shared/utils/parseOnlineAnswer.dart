import 'package:intl/intl.dart';

Map<String,dynamic> parseOnlineAnswer(Map<String,dynamic> rawAnswer){
  assert(rawAnswer != null);
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    if (rawAnswer["date"] != null) {
      rawAnswer["date"] =
          dateFormat.parse(rawAnswer["date"].substring(0, 10));
    }
    // parse the values to their respective format
    Map<String, dynamic> answer = rawAnswer;
    Map<String, dynamic> newAnswer = Map<String, dynamic>();
    answer.forEach((key, value) {
      if (value.runtimeType == List<dynamic>().runtimeType) {
        newAnswer["$key"] = List<String>.from(value);
      } else {
        newAnswer["$key"] = value;
      }
    });
  return newAnswer;
}