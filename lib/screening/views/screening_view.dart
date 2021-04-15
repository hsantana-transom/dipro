import 'package:animations/animations.dart';
import 'package:dipro/constants.dart';
import 'package:dipro/screening/screening_bloc/screening_bloc.dart';
import 'package:dipro/screening/views/screening_field_category_question.dart';
import 'package:dipro/screening/views/screening_report_question.dart';
import 'package:dipro/screening/views/screening_result_handler.dart';
import 'package:dipro/screening/views/screening_service_type_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class ScreeningView extends StatefulWidget {
  ScreeningView({Key key}) : super(key: key);

  @override
  _ScreeningViewState createState() => _ScreeningViewState();
}

enum ScreeningViews {
  reportQuestion,
  serviceTypeQuestion,
  fieldCategoryQuestion,
  resultScreening
}

class _ScreeningViewState extends State<ScreeningView> {
  ScreeningViews screeningCurrentQuestion = ScreeningViews.reportQuestion;
  bool reverseAnimation = false;
  String report;
  String serviceType;
  String fieldCategory;
  // function to go back depending on the current state
  goBack() {
    switch (screeningCurrentQuestion) {
      case ScreeningViews.reportQuestion:
        Get.back();
        break;
      case ScreeningViews.serviceTypeQuestion:
        screeningCurrentQuestion = ScreeningViews.reportQuestion;
        break;
      case ScreeningViews.fieldCategoryQuestion:
        screeningCurrentQuestion = ScreeningViews.serviceTypeQuestion;
        break;
      case ScreeningViews.resultScreening:
        Get.back();
        break;
      default:
        break;
    }
    setState(() {});
  }

  final ScreeningBloc screeningBloc = ScreeningBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'screening.appbar.title.label'.tr,
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: IconButton(
          icon: Icon(FlutterIcons.arrow_left_faw),
          color: Colors.black,
          onPressed: goBack,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: paddingXL,
          vertical: paddingM,
        ),
        child: BlocProvider<ScreeningBloc>(
          create: (_) => screeningBloc,
          child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 300),
              reverse: reverseAnimation,
              transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  child: child,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                );
              },
              child: getCurrentQuestion()),
        ),
      ),
    );
  }

  // ignore: missing_return
  Widget getCurrentQuestion() {
    switch (screeningCurrentQuestion) {
      case ScreeningViews.reportQuestion:
        return ScreeningReportQuestion(
          onFinished: (report) {
            setState(() {
              this.report = report;
              this.screeningCurrentQuestion =
                  ScreeningViews.serviceTypeQuestion;
            });
          },
        );
        break;
      case ScreeningViews.serviceTypeQuestion:
        return ScreeningServiceTypeQuestion(
          onFinished: (serviceType) {
            if (serviceType != 'field') {
              screeningBloc.add(ScreeningResultCompleted(
                  report: report,
                  serviceType: serviceType,
                  fieldCategory: fieldCategory));
            }
            setState(() {
              this.serviceType = serviceType;
              this.screeningCurrentQuestion = serviceType == 'field'
                  ? ScreeningViews.fieldCategoryQuestion
                  : ScreeningViews.resultScreening;
            });
          },
        );
        break;
      case ScreeningViews.fieldCategoryQuestion:
        return ScreeningFieldCategoryQuestion(
          onFinished: (fieldCategory) {
            screeningBloc.add(ScreeningResultCompleted(
                report: report,
                serviceType: serviceType,
                fieldCategory: fieldCategory));
            setState(() {
              this.fieldCategory = fieldCategory;
              this.screeningCurrentQuestion = fieldCategory == ''
                  ? ScreeningViews.fieldCategoryQuestion
                  : ScreeningViews.resultScreening;
            });
          },
        );
        break;
      case ScreeningViews.resultScreening:
        return ScreeningResultHandler(
          report: report,
          serviceType: serviceType,
          fieldCategory: fieldCategory,
        );
        break;
      default:
        break;
    }
  }
}
