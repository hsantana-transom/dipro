import 'dart:io';

import 'package:dio/dio.dart';

Future<Map<String,dynamic>> toPhotoMultipartList(List<File> photos) async {
  Map<String,dynamic> parsedPhotos;
  int i;
  return await Future.forEach(photos, (photo) async {
      String fileName = photo.path.split('/').last;
      parsedPhotos['photo$i'] =
          await MultipartFile.fromFile(photo.path, filename: fileName);
      i++;
    });
}