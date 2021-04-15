part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];

  @override 
  bool get stringify => true;
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  @override 
  bool get stringify => true;
}
