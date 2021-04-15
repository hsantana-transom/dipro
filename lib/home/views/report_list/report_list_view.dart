import 'package:dipro/home/bloc/reports_bloc.dart';
import 'package:dipro/home/views/report_list/report_grid_tile.dart';
import 'package:flutter/material.dart';

class ReportListView extends StatelessWidget {
  ReportListView({Key key, this.state}) : super(key: key);

  final ReportsState state;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: state.reports.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2 / 2,
        crossAxisCount: 3,
      ),
      itemBuilder: (context, count) => ReportGridTile(
        state: state,
        count: count,
      ),
    );
  }
}
