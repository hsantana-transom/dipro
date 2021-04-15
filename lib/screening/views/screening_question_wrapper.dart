import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dipro/constants.dart';
import 'package:get/get.dart';

class ScreeningQuestionWrapper extends StatelessWidget {
  ScreeningQuestionWrapper({Key key, this.onFinished, this.children})
      : super(key: key);

  final Function(Map<String, dynamic> results) onFinished;
  final List<Widget> children;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children..insertAll(children.length, [
          SizedBox(
              height: spaceL,
            ),
            SizedBox(
              height: spaceXXL,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (_fbKey.currentState.saveAndValidate()) {
                    Map<String,dynamic> results = _fbKey.currentState.value;
                    onFinished(results);
                  }
                },
                child: Text(
                  "screening.next_button.label".tr.toUpperCase(),
                ),
              ),
            )
        ]),
      ),
    );
  }
}
