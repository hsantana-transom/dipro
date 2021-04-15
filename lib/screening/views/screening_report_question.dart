import 'package:dipro/constants.dart';
import 'package:dipro/shared/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ScreeningReportQuestion extends StatelessWidget {
  ScreeningReportQuestion({Key key, this.onFinished, this.children})
      : super(key: key);

  final Function(String report) onFinished;
  final List<Widget> children;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final FocusNode fn = FocusNode();
  final Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Flexible(
          child: Text('screening.report.question.label'.tr,
              style: Theme.of(context).textTheme.headline5),
        ),
        FormBuilderRadioGroup(
          focusNode: fn,
          controlAffinity: ControlAffinity.leading,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          orientation: OptionsOrientation.vertical,
          name: 'report',
          validator: FormBuilderValidators.required(context),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          options: [
            FormBuilderFieldOption(
              child: Text('JSA', style: Theme.of(context).textTheme.subtitle1),
              value: 'JSA',
            ),
          ],
        ),
        SizedBox(
          height: spaceL,
        ),
        SizedBox(
          height: spaceXXL,
          width: MediaQuery.of(context).size.width,
          child: GradientElevatedButton(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.red[300], Colors.red[400]],
            ),
            style: ButtonStyle(
              shadowColor: MaterialStateProperty.resolveWith(
                (states) => Colors.red,
              ),
              elevation: MaterialStateProperty.resolveWith((states) {
                if (states.any(interactiveStates.contains)) {
                  return 10;
                }
                return 4;
              }),
            ),
            onPressed: () {
              if (_fbKey.currentState.saveAndValidate()) {
                Map<String, dynamic> results = _fbKey.currentState.value;
                onFinished(results['report']);
              }
            },
            child: Text(
              "screening.next_button.label".tr.toUpperCase(),
            ),
          ),
        )
      ]),
    );
  }
}
