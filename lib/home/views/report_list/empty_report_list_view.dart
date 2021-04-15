import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dipro/constants.dart';

class EmptyReportListView extends StatelessWidget {
  const EmptyReportListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'home.body.empty.label'.tr,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spaceXL),
          Center(
            child: Image.asset(
              'assets/images/create.png',
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
