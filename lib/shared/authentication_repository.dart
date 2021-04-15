import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dipro/shared/api/api_client.dart';
import 'package:dipro/shared/repositories/token_repository.dart';
import 'package:meta/meta.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  // singleton setup
  static final AuthenticationRepository _instance =
      AuthenticationRepository._internal();
  factory AuthenticationRepository() => _instance;
  AuthenticationRepository._internal();

  //auth controller
  final _controller = StreamController<AuthenticationStatus>.broadcast();
  // token repository
  final TokenRepository tokenRepository = TokenRepository();
  // api client setup
  ApiClient _apiClient = ApiClient();
  Dio get client => _apiClient.client;

  //status stream wrapper
  Stream<AuthenticationStatus> get status async* {
    String accessToken = await tokenRepository.getAccessToken();
    String refreshToken = await tokenRepository.getRefreshToken();
    if (accessToken != null && refreshToken != null) {
      await _apiClient.setAuthenticationHeader();
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  // login request function
  Future<void> logIn({
    @required String username,
    @required String password,
  }) async {
    // ensures the references arent null
    assert(username != null);
    assert(password != null);
    // api login
    Response response = await client.post('/auth/login', data: {
      'email': username,
      'password': password,
    });
    await tokenRepository.saveTokens(
      accessToken: response.data["access_token"],
      refreshToken: response.data["refresh_token"],
    );
    await _apiClient.setAuthenticationHeader();
    // set authentication status
    _controller.add(AuthenticationStatus.authenticated);
  }
  // logout request function
  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    _apiClient.removeAuthenticationHeader();
    tokenRepository.saveTokens(accessToken: null, refreshToken: null);
  }

  void dispose() => _controller.close();
}
