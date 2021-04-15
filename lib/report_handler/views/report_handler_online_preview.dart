import 'package:dipro/report_handler/bloc/report_handler_bloc.dart';
import 'package:dipro/report_handler/views/report_handler_form_view.dart';
import 'package:dipro/report_handler/views/report_hanlder_photo_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class ReportHandlerOnlinePreview extends StatelessWidget {
  ReportHandlerOnlinePreview({Key key, this.state}) : super(key: key);

  final ReportHandlerState state;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "report_handler.title.label".tr,
              style: TextStyle(color: Colors.black),
            ),
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              },
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    FlutterIcons.file_invoice_faw5s,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Tab(
                  icon: Icon(
                    FlutterIcons.image_faw5s,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            )),
        body: TabBarView(
          children: [
            ReportHandlerFormView(state: state),
            ReportHandlerPhotoGridView(state: state)
          ],
        ),
      ),
    );
  }
}
