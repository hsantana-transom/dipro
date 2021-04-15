import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_icons/flutter_icons.dart';

class FormBuilderPasswordField extends StatefulWidget {
  const FormBuilderPasswordField({
    Key key,
    this.focusNode,
    this.textInputAction,
    this.decoration,
    this.validator,
    this.name,
    this.onSubmitted,
  }) : super(key: key);

  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final InputDecoration decoration;
  final FormFieldValidator validator;
  final String name;
  final ValueChanged<String> onSubmitted;

  @override
  _FormBuilderPasswordFieldState createState() => _FormBuilderPasswordFieldState();
}

class _FormBuilderPasswordFieldState extends State<FormBuilderPasswordField> {

  bool obscureText = true;

  void toggleObscureText(){
    setState((){
      obscureText = !this.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      decoration: widget.decoration.copyWith( 
        suffixIcon: IconButton(
          icon: AnimatedCrossFade(
            firstChild: Icon(FlutterIcons.eye_mco,),
            secondChild: Icon(FlutterIcons.eye_off_mco),
            duration: const Duration(milliseconds: 200),
            crossFadeState: obscureText ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
          onPressed: toggleObscureText,
        )
      ),
      validator: widget.validator,
      name: widget.name,
      obscureText: obscureText,
      onSubmitted: widget.onSubmitted,
    );
  }
}