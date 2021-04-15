import 'package:dipro/home/bloc/reports_bloc.dart';
import 'package:dipro/report_handler/views/report_handler_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class ReportGridTile extends StatelessWidget {
  ReportGridTile({Key key, this.state, this.count}) : super(key: key);

  final ReportsState state;
  final int count;

  void toEditView(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportHandlerBuilder(
          report: state.reports[count],
        ),
      ),
    );
  }

  void showDeleteDialog(context) {
    Get.defaultDialog(
      title: '¿Desea eliminar este reporte?',
      content: Container(),
      textConfirm: 'Confirmar',
      textCancel: 'Cancelar',
      confirmTextColor: Colors.white,
      onConfirm: () {
        // ignore: close_sinks
        ReportsBloc reportsBloc = Get.find();
        reportsBloc.add(ReportsSingleDeleteRequested(state.reports[count].key));
        Navigator.pop(context);
      },
      onCancel: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          toEditView(context);
        },
        child: GridTile(
          header: state.reports[count].isOnline == true
              ? Container()
              : Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(FlutterIcons.delete_ant, color: Colors.red),
                      onPressed: () {
                        showDeleteDialog(context);
                      },
                    ),
                  ),
                ),
          footer: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(state.reports[count].isOnline == true
                  ? FlutterIcons.ios_cloud_done_ion
                  : FlutterIcons.cloud_off_mdi),
            ),
          ),
          child: Container(
            child: Center(
              child: Text(
                'Reporte #${state.reports[count].key}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
