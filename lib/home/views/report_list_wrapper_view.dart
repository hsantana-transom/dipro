import 'package:dipro/home/bloc/reports_bloc.dart';
import 'package:dipro/home/views/empty_report_list_view.dart';
import 'package:dipro/home/views/report_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportListWrapperView extends StatelessWidget {
  ReportListWrapperView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        if (state.status == ReportsStatus.loading ||
            state.status == ReportsStatus.pure) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (state.reports.length == 0) {
            return EmptyReportListView();
          } else {
            return ReportListView(state: state);
          }
        }
      },
    );
  }
}
