import 'package:dipro/report_handler/bloc/report_handler_bloc.dart';
import 'package:dipro/report_handler/views/report_handler_photo_grid_tile.dart';
import 'package:flutter/material.dart';

class ReportHandlerPhotoGridView extends StatelessWidget {
  const ReportHandlerPhotoGridView({Key key, this.state}) : super(key: key);

  final ReportHandlerState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: GridView.builder(
          itemCount: state.report.photos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (context, i) =>
              ReportHandlerPhotoGridTile(state: state, i: i),
        ),
      ),
    );
  }
}
