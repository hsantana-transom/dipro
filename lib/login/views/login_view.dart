import 'package:dipro/constants.dart';
import 'package:dipro/login/bloc/login_bloc.dart';
import 'package:dipro/login/views/login_form.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        authenticationRepository: Get.find(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: KeyboardAvoider(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: paddingXL,
              vertical: paddingM,
            ),
            child: LoginForm()
          ),
        ),
      ),
    );
  }
}
