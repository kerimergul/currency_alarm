import 'package:currency_alarm/ui/styles/style.dart';
import 'package:flutter/material.dart';

class LoginTextForm extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Icon icon;
  final TextInputType keyboardType;
  final String errorText;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final FormFieldSetter<String> onSaved;

  const LoginTextForm(
      {Key key,
      this.hintText,
      this.labelText,
      this.icon,
      this.keyboardType,
      this.errorText,
      this.validator,
      this.obscureText,
      this.onSaved})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: formTextStyle,
        decoration: InputDecoration(
          fillColor: Colors.white,
          errorStyle: formTextStyle,
          hintStyle: formTextStyle,
          labelStyle: formTextStyle,
          prefixStyle: formTextStyle,
          prefix: icon != null ? icon : null,
          errorText: errorText != null ? errorText : null,
          hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        obscureText: obscureText != null ? obscureText : false,
        keyboardType: keyboardType != null ? keyboardType : null,
        validator: validator,
        onSaved: onSaved);
  }
}
