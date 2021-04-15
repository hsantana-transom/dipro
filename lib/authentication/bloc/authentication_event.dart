part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable{}

// triggers when there is a change on the authentication status 
class AuthenticationStatusChanged extends AuthenticationEvent {
  AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];

  @override 
  bool get stringify => true;
}
// triggers when a request of logout is received
class AuthenticationLogoutRequest extends AuthenticationEvent{

  @override
  List<Object> get props => [];

  @override 
  bool get stringify => true;
}
