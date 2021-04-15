import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:dipro/authentication/bloc/authentication_bloc.dart';
import 'package:dipro/authentication/views/authentication_handler.dart';
import 'package:dipro/constants.dart';
import 'package:dipro/home/bloc/reports_bloc.dart';
import 'package:dipro/messages.dart';
import 'package:dipro/settings/views/settings_view.dart';
import 'package:dipro/shared/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  final userRepository = UserRepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // makes the report bloc global available
    return BlocProvider.value(
      value: Get.find<ReportsBloc>(),
      // connection wrapper
      child: ConnectivityAppWrapper(
        app: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Dipro',
            // translation configuration
            translations: Messages(),
            localizationsDelegates: [
              FormBuilderLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
            ],
            supportedLocales: [
              Locale('es', 'MX'),
              Locale('pt', 'BR'),
            ],
            locale: Locale('es', 'MX'),
            fallbackLocale: Locale('es', 'MX'),
            theme: customThemeData,
            home: BlocProvider(
              create: (_) => AuthenticationBloc(
                authenticationRepository: Get.find(),
                userRepository: UserRepository(),
              ),
              child: AuthenticationHandler(),
            ),
            routes: {
              '/settings': (context) => SettingsView(),
            }),
      ),
    );
  }
}
