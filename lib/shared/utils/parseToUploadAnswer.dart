Map<String, dynamic> parseToUploadAnswer(Map<String, dynamic> answer) {
  // initialized containers for the values to be upload
  Map<String, dynamic> parsedAnswer = Map<String, dynamic>();

  // parse the diferent values to their respective format
  answer.forEach((key, value) {
    if (value.runtimeType == DateTime(2020).runtimeType) {
      parsedAnswer['$key'] = value.toString();
    } else if (key != 'photos' &&
        value.runtimeType == List<dynamic>().runtimeType) {
      parsedAnswer['$key'] = List<String>.from(value);
    } else if(key != 'photos'){
      parsedAnswer['$key'] = value.toString();
    }
  });

  return parsedAnswer;
}
