import 'package:dipro/app.dart';
import 'package:dipro/shared/authentication_repository.dart';
import 'package:dipro/home/bloc/reports_bloc.dart';
import 'package:dipro/shared/models/custom_bloc_observer.dart';
import 'package:dipro/shared/utils/init_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

void main() async {
  // add custom bloc observer to print the bloc status
  Bloc.observer = CustomBlocObserver();
  await addServices();
  // prevent orientation change
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

Future<void> addServices() async {
  // load environment variables and initialize local database
  await DotEnv().load('assets/.env');
  await InitDatabase.initialize();
  // put the singleton instances on  get
  Get.put(AuthenticationRepository());
  Get.put(ReportsBloc());
}
