import 'dart:convert';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:dipro/home/bloc/reports_bloc.dart';
import 'package:dipro/report_handler/views/report_handler_preview_controls.dart';
import 'package:dipro/screening/screening_bloc/screening_bloc.dart';
import 'package:dipro/screening/views/screening_result_error.dart';
import 'package:dipro/screening/views/screening_result_loading.dart';
import 'package:dipro/shared/models/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:json_form_builder/json_form_builder.dart';

class ScreeningResultHandler extends StatefulWidget {
  ScreeningResultHandler(
      {Key key, this.report, this.serviceType, this.fieldCategory})
      : super(key: key);

  final String report;
  final String serviceType;
  final String fieldCategory;

  @override
  _ScreeningResultHandlerState createState() => _ScreeningResultHandlerState();
}

class _ScreeningResultHandlerState extends State<ScreeningResultHandler> {
  bool formEnabled = true;
  final ScrollController scrollController = ScrollController();
  Map<String, dynamic> results;
  final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  void submitReport(state, values) async {
    if (await ConnectivityWrapper.instance.isConnected) {
      // ignore: close_sinks
      ReportsBloc reportsBloc = Get.find();
      reportsBloc
          .add(ReportsSingleUploadRequested(state.reportInstance, values));
    } else {
      Get.defaultDialog(
        title: "screening.report.error.label".tr,
        content: Text("screening.report.bad_connection.content.label".tr),
      );
    }
  }

  void showIncompleteDialog(Report report, Map<String, dynamic> answer) {
    // ignore: close_sinks
    ReportsBloc reportsBloc = Get.find();
    reportsBloc.add(ReportsSingleLocalUpdateRequested(report, answer));
    Get.defaultDialog(
      title: "screening.report.error.label".tr,
      content: Text("screening.report.error.content.label".tr),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreeningBloc, ScreeningState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state.status == ScreeningStatus.loading) {
          return ScreeningResultLoading();
        } else if (state.status == ScreeningStatus.success) {
          return NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return false;
            },
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: JsonFormBuilder(
                    fbKey: fbKey,
                    scrollController: scrollController,
                    padding: EdgeInsets.zero,
                    enabled: formEnabled,
                    json: jsonEncode(state.reportInstance
                        .reportSchema[Get.locale.languageCode.toLowerCase()]),
                    onSubmittedAndValid: (values) async {
                      await scrollController.animateTo(
                        0,
                        duration: Duration(microseconds: 300),
                        curve: Curves.ease,
                      );
                      setState(() {
                        this.formEnabled = false;
                        this.results = values;
                      });
                    },
                    onSubmittedAndNotValid: (values) {
                      showIncompleteDialog(state.reportInstance, values);
                    },
                    // onChanged: () {
                    //   fbKey.currentState.save();
                    //   // ignore: close_sinks
                    //   ReportsBloc reportsBloc = Get.find();
                    //   reportsBloc.add(ReportsSingleLocalUpdateRequested(
                    //       state.reportInstance, fbKey.currentState.value));
                    // },
                    onWillPop: () async {
                      fbKey.currentState.save();
                      fbKey.currentState.value.forEach((key, value) {
                        print('$key $value');
                      });
                      // ignore: close_sinks
                      ReportsBloc reportsBloc = Get.find();
                      reportsBloc.add(ReportsSingleLocalUpdateRequested(
                          context.read<ScreeningBloc>().state.reportInstance,
                          fbKey.currentState.value));
                      return true;
                    },
                  ),
                ),
                ReportHandlerPreviewControls(
                  isVisible: formEnabled == false,
                  onBackPressed: () {
                    setState(() {
                      this.formEnabled = true;
                    });
                  },
                  onSubmitPressed: () {
                    submitReport(state, results);
                  },
                ),
              ],
            ),
          );
        } else if (state.status == ScreeningStatus.failure) {
          return ScreeningResultError();
        }
      },
    );
  }
}
