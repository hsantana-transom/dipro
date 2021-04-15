import 'package:dipro/constants.dart';
import 'package:dipro/home/bloc/reports_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ReportHandlerPreviewControls extends StatelessWidget {
  ReportHandlerPreviewControls({
    Key key,
    this.isVisible,
    this.onBackPressed,
    this.onSubmitPressed,
  }) : super(key: key);

  final bool isVisible;
  final Function onBackPressed;
  final Function onSubmitPressed;
  final ReportsBloc reportsBloc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: SizedBox(
        height: spaceXXL + spaceXS,
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: spaceXXL,
                width: (MediaQuery.of(context).size.width / 2) - spaceXXL,
                child: Container(
                  color: Colors.transparent,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.red,
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.white,
                      ),
                      shadowColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.red,
                      ),
                    ),
                    child: Text('report_handler.back.label'.tr),
                    onPressed: this.onBackPressed,
                  ),
                ),
              ),
              SizedBox(
                width: spaceM,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              SizedBox(
                height: spaceXXL,
                width: (MediaQuery.of(context).size.width / 2) - spaceXXL,
                child: Container(
                  color: Colors.transparent,
                  child: BlocBuilder<ReportsBloc,ReportsState>(
                    cubit: Get.find(),
                    builder: (context, state) => ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green,
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white,
                        ),
                        shadowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green,
                        ),
                      ),
                      child: state.status == ReportsStatus.loading
                          ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
                          : Text('report_handler.submit.label'.tr),
                      onPressed: state.status == ReportsStatus.loading ? null : this.onSubmitPressed,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
