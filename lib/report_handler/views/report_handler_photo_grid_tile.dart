import 'package:dipro/report_handler/bloc/report_handler_bloc.dart';
import 'package:flutter/material.dart';

class ReportHandlerPhotoGridTile extends StatelessWidget {
  const ReportHandlerPhotoGridTile({Key key, this.state, this.i}) : super(key: key);

  final ReportHandlerState state;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridTile(
        child: Image.network(
          state.report.photos[i],
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
