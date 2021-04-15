import 'dart:convert';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:dipro/constants.dart';
import 'package:dipro/home/bloc/reports_bloc.dart';
import 'package:dipro/report_handler/views/report_handler_preview_controls.dart';
import 'package:dipro/shared/models/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:json_form_builder/json_form_builder.dart';

class ReportHandlerEditView extends StatefulWidget {
  ReportHandlerEditView({Key key, this.report}) : super(key: key);

  final Report report;

  @override
  _ReportHandlerEditViewState createState() => _ReportHandlerEditViewState();
}

class _ReportHandlerEditViewState extends State<ReportHandlerEditView> {
  bool formEnabled = true;
  final ScrollController scrollController = ScrollController();
  Map<String, dynamic> results;
  final GlobalKey<FormBuilderState> fbKey = GlobalKey();

  void submitReport() async {
    // ignore: close_sinks
    ReportsBloc reportsBloc = Get.find();
    if (await ConnectivityWrapper.instance.isConnected) {
      reportsBloc.add(ReportsSingleUploadRequested(widget.report, results));
    } else {
      reportsBloc
          .add(ReportsSingleLocalUpdateRequested(widget.report, results));
      Get.defaultDialog(
        title: "report_handler.local_report.success.label".tr,
        content: Text("report_handler.local_report.success.content.label".tr),
      );
    }
  }

  void showIncompleteDialog(Map<String, dynamic> answer) {
    // ignore: close_sinks
    ReportsBloc reportsBloc = Get.find();
    reportsBloc.add(ReportsSingleLocalUpdateRequested(widget.report, answer));
    Get.defaultDialog(
      title: "screening.report.error.label".tr,
      content: Text("screening.report.error.content.label".tr),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(FlutterIcons.arrow_left_faw),
          color: Colors.black,
          onPressed: () {
            // ignore: close_sinks
            ReportsBloc reportsBloc = Get.find();
            fbKey.currentState.save();
            reportsBloc.add(ReportsSingleLocalUpdateRequested(
                widget.report, fbKey.currentState.value));
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingXL),
        child: NotificationListener<OverscrollIndicatorNotification>(
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
                  initialValue: widget.report.reportSchema.containsKey("answer")
                      ? widget.report.reportSchema["answer"]
                      : {},
                  json: jsonEncode(widget.report
                      .reportSchema[Get.locale.languageCode.toLowerCase()]),
                  // onChanged: () {
                  //   fbKey.currentState.save();
                  //   // ignore: close_sinks
                  //   ReportsBloc reportsBloc = Get.find();
                  //   reportsBloc.add(ReportsSingleLocalUpdateRequested(
                  //       widget.report, fbKey.currentState.value));
                  // },
                   onWillPop: () async {
                    fbKey.currentState.save();
                    // ignore: close_sinks
                    fbKey.currentState.value.forEach((key, value) {
                        print('$key $value');
                      });
                    ReportsBloc reportsBloc = Get.find();
                    reportsBloc.add(ReportsSingleLocalUpdateRequested(
                        widget.report, fbKey.currentState.value));
                    return true;
                  },
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
                    showIncompleteDialog(values);
                  },
                ),
              ),
              ReportHandlerPreviewControls(
                isVisible: !formEnabled,
                onBackPressed: () {
                  setState(() {
                    this.formEnabled = true;
                  });
                },
                onSubmitPressed: () {
                  submitReport();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
