import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dipro/shared/authentication_repository.dart';
import 'package:dipro/shared/models/models.dart';
import 'package:dipro/shared/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

// Bloc that handles the authentication status
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
    @required UserRepository userRepository,
  }) : 
  assert(authenticationRepository != null),
  assert(userRepository != null),
  _authenticationRepository = authenticationRepository,
  _userRepository = userRepository,
  super(const AuthenticationState.unknown()){
    _authenticationStatusSubscription = _authenticationRepository.status.listen( 
      (status) => add(AuthenticationStatusChanged(status))
    );
  }
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  // dispose the streams
  @override
  Future<void> close(){
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AuthenticationStatusChanged){
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequest){
      _authenticationRepository.logOut();
    }
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event
  ) async {
    switch(event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      // try to get the user
      case AuthenticationStatus.authenticated: 
        final user = await _tryGetUser();
        return  user != null
          ? AuthenticationState.authenticated(user)
          : const AuthenticationState.unauthenticated();
      // just in case it happens
      default: 
        return const AuthenticationState.unknown();
    }
  }

  Future<User> _tryGetUser() async{
    try{
      final user = await _userRepository.getUser();
      return user;
    } on DioError catch(e) {
      return null;
    } catch (e) {
      return null;
    }
  }
}
