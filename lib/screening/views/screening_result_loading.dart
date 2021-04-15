import 'package:flutter/material.dart';
import 'package:dipro/constants.dart';
import 'package:get/get.dart';

class ScreeningResultLoading extends StatelessWidget {
  const ScreeningResultLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text('screening.loading.label'.tr,
                style: Theme.of(context).textTheme.headline6),
          ),
          SizedBox(height: spaceXL),
          Container(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
