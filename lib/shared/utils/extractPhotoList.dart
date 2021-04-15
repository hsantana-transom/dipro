import 'dart:io';

List<File> extractPhotoList(Map<String,dynamic> answer){
  if(answer.containsKey("photos")){
    return List<File>.from(answer["photos"]);
  } 
    return [];
}