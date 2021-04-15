import 'package:dipro/report_handler/bloc/report_handler_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_form_builder/json_form_builder.dart';
import 'dart:convert' as json;

class ReportHandlerFormView extends StatelessWidget {
  ReportHandlerFormView({Key key, this.state}) : super(key: key);

  final ReportHandlerState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: JsonFormBuilder(
          initialValue: state.report.reportSchema["answer"],
          enabled: state.report.isOnline == false,
          json: json.jsonEncode(
            state.report.reportSchema[Get.locale.languageCode.toLowerCase()],
          ),
        ),
      ),
    );
  }
}
