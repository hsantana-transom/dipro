import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dipro/shared/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';
part 'login_state.dart';

enum LoginStatus { success, error, loading, pure }
// LoginBloc that manage the form status
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required this.authenticationRepository})
      : assert(authenticationRepository != null),
        super(LoginState.pure());

  final AuthenticationRepository authenticationRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSubmitted) {
      yield LoginState.loading();
      try {
        await authenticationRepository.logIn(
          username: event.email,
          password: event.password,
        );
        yield LoginState.success();
      } on DioError catch (error) {
        print(error.request.uri);
        print(error.response);
        yield LoginState.error();
      } on Error catch (error) {
        print(error);
        yield LoginState.error();
      }
    }
  }
}
