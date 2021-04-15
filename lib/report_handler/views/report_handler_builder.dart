import 'package:dipro/report_handler/bloc/report_handler_bloc.dart';
import 'package:dipro/report_handler/views/report_handler_edit_view.dart';
import 'package:dipro/report_handler/views/report_handler_online_preview.dart';
import 'package:dipro/shared/models/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ReportHandlerBuilder extends StatelessWidget {
  ReportHandlerBuilder({Key key, this.report}) : super(key: key);

  final Report report;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportHandlerBloc()..add(ReportHandlerAdded(this.report)),
      child: Builder(
        builder: (context) => BlocBuilder<ReportHandlerBloc, ReportHandlerState>(
          builder: (context, state) {
            if (state.status == ReportHandlerStatus.pure ||
                state.status == ReportHandlerStatus.loading) {
              return Scaffold(
                body: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else {
              if(report.isOnline){
                return ReportHandlerOnlinePreview(state: state);
              } else {
                return ReportHandlerEditView(report: report);
              }
            }
          },
        ),
      ),
    );
  }
}
