import 'package:dipro/authentication/bloc/authentication_bloc.dart';
import 'package:dipro/shared/authentication_repository.dart';
import 'package:animations/animations.dart';
import 'package:dipro/authentication/views/splash_view.dart';
import 'package:dipro/home/views/home_view.dart';
import 'package:dipro/login/views/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AuthenticationHandler extends StatelessWidget {
  const AuthenticationHandler({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return PageTransitionSwitcher(
          duration: const Duration(milliseconds: 3000),
          reverse: state.status != AuthenticationStatus.authenticated,
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled,
            );
          },
          child: Builder(
            builder: (context) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  return HomeView();
                case AuthenticationStatus.unauthenticated:
                  return LoginView();
                default:
                  return SplashView();
              }
            },
          ),
        );
      },
    );
  }
}
