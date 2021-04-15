import 'package:dipro/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode fnLanguage = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('settings.appbar.title.label'.tr, style: Theme.of(context).textTheme.headline6),
        leading: IconButton(
          icon: Icon(
            FlutterIcons.arrow_left_faw,
            color: Colors.black,
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: KeyboardAvoider(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: paddingXL,
            vertical: paddingM,
          ),
          child: FormBuilder(
            key: _formKey,
            initialValue: {
              'language': Get.locale,
            },
            child: Column(
              children: [
                FormBuilderSegmentedControl(
                  focusNode: fnLanguage,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'settings.form.language.label'.tr
                  ),
                  name: 'language',
                  onChanged: (locale){
                    Get.updateLocale(locale);   
                  },
                  options: [
                    FormBuilderFieldOption(
                      child: Text('Español'),
                      value: Locale('es', 'MX'),
                    ),
                    FormBuilderFieldOption(
                      child: Text('Portugues'),
                      value: Locale('pt', 'BR'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
