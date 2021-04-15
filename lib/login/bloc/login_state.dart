part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState._({
    this.status,
  });

  const LoginState.pure()
      : this._(
          status: LoginStatus.pure,
        );

  const LoginState.loading()
      : this._(
          status: LoginStatus.loading,
        );

  const LoginState.error()
      : this._(
          status: LoginStatus.error,
        );

  const LoginState.success()
      : this._(
          status: LoginStatus.success,
        );

  final LoginStatus status;

  @override
  List<Object> get props => [status];

  @override 
  bool get stringify => true;
}
