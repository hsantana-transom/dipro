import 'dart:async';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:dio/dio.dart';
import 'package:dipro/shared/api/api_client.dart';
import 'package:dipro/shared/models/models.dart';

class UserRepository {
  User _user;
  ApiClient _apiClient = ApiClient();
  Dio get client => _apiClient.client; 

  Future<User> getUser() async {
    if(_user != null) return _user;
    try {
      Response response = await client.get('/auth/me');
      return User(response.data["id"]);
    } on DioError catch(_){
      if( await ConnectivityWrapper.instance.isConnected ){
        return null;
      }else{
        return User(1);
      }
    }
  }
}