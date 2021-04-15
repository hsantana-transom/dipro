import 'package:dio/dio.dart';
import 'package:dipro/shared/authentication_repository.dart';
import 'package:dipro/shared/repositories/token_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' as Get;

// Singleton api client
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  final TokenRepository tokenRepository = TokenRepository();

  ApiClient._internal() {
    client.options.baseUrl = DotEnv().env['IS_PROD'] == 'true'
        ? DotEnv().env['PROD_BASE_URL']
        : DotEnv().env['DEV_BASE_URL'];
    client.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      return options; //continue
    }, onResponse: (Response response) async {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      if (e?.response != null &&
          e.response.statusCode >= 400 &&
          e.response.statusCode <= 600) {
        print(e.response.data);
        print(e.response.statusCode);
        print(e.response.statusMessage);
        Get.Get.defaultDialog(
            title: 'Error',
            middleText: e?.response?.data["message"] != null
                ? e.response.data["message"]
                : e.response.data["error"]);
        if (e.response.statusCode == 401 || e.response.statusCode == 405) {
          AuthenticationRepository authenticationRepository = Get.Get.find();
          authenticationRepository.logOut();
        }
      }
      return e; //continue
    }));
    print("IS_PROD: ${DotEnv().env['IS_PROD']}");
    print("PROD: ${DotEnv().env['PROD_BASE_URL']}");
    print("DEV: ${DotEnv().env['DEV_BASE_URL']}");
  }

  factory ApiClient() {
    return _instance;
  }

  final Dio client = Dio();

  Future<void> setAuthenticationHeader() async {
    String accessToken = await tokenRepository.getAccessToken();
    client.options.headers["Authorization"] = 'Bearer $accessToken';
  }

  void removeAuthenticationHeader() async {
    client.options.headers.remove("Authorization");
  }
}
