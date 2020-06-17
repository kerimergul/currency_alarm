import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;

  const LoginButton(
      {Key key,
      @required this.onPressed,
      @required this.buttonText,
      @required this.buttonColor,
      @required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: textColor),
      ),
      color: buttonColor,
    );
  }
}
