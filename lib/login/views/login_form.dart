import 'package:dipro/constants.dart';
import 'package:dipro/login/bloc/login_bloc.dart';
import 'package:dipro/shared/widgets/form_builder_password_field.dart';
import 'package:dipro/shared/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key key}) : super(key: key);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final FocusNode fnEmail = FocusNode();
  final FocusNode fnPassword = FocusNode();

  final Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: Image.asset(
              'assets/images/icon.png',
              height: 150,
            ),
          ),
          SizedBox(
            height: spaceXXL,
          ),
          FormBuilderTextField(
            name: 'email'.tr,
            decoration: InputDecoration(
              labelText: "login.form.email.label".tr,
            ),
            textInputAction: TextInputAction.next,
            onSubmitted: (email) {
              FocusScope.of(context).requestFocus(fnPassword);
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.email(context)
            ]),
          ),
          SizedBox(
            height: spaceL,
          ),
          FormBuilderPasswordField(
              name: 'password',
              decoration: InputDecoration(
                labelText: 'login.form.password.label'.tr,
              ),
              validator: FormBuilderValidators.required(context),
              focusNode: fnPassword,
              textInputAction: TextInputAction.done,
              onSubmitted: (string) {
                FocusScope.of(context).unfocus();
              }),
          SizedBox(
            height: spaceXL,
          ),
          SizedBox(
            height: spaceXXL,
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                print(state.status);
                return GradientElevatedButton(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.red[300], Colors.red[400]],
                  ),
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.red,
                    ),
                    elevation: MaterialStateProperty.resolveWith((states) {
                      if (states.any(interactiveStates.contains)) {
                        return 10;
                      }
                      return 4;
                    }),
                  ),
                  onPressed: () {
                    if (state.status != LoginStatus.loading) {
                      FocusScope.of(context).unfocus();
                      if (_fbKey.currentState.saveAndValidate()) {
                        Map<String, dynamic> loginData =
                            _fbKey.currentState.value;
                        context.read<LoginBloc>().add(
                              LoginSubmitted(
                                email: loginData['email'],
                                password: loginData['password'],
                              ),
                            );
                      }
                    }
                  },
                  child: state.status == LoginStatus.loading
                      ? CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        )
                      : Text(
                          "login.form.submit.label".tr.toUpperCase(),
                        ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
