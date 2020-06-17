import 'package:currency_alarm/blocs/auth/bloc.dart';
import 'package:currency_alarm/model/user.dart';
import 'package:currency_alarm/ui/Widgets/common/formFields/loginTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({Key key, this.title}) : super(key: key);

  final CreateAccountPage title;

  String _emailPasswordCheck(String email, String password) {
    String result = "true";
    if (password.length < 6) {
      result = "password";
    }
    if (!email.contains("@")) {
      result = "email";
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);
    final _formKey = GlobalKey<FormState>();
    String _email;
    String _password;
    String _passControl;

    _createAccount() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        if (_password == _passControl) {
          final String result = _emailPasswordCheck(_email, _password);
          if (result == "true") {
            final User user = new User.account(_email, _password);
            _authBloc.dispatch(CreateAccountEvent(user: user));
            Navigator.pop(context);
          } else {}
        }
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/default_user.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      LoginTextForm(
                          icon: Icon(Icons.mail,
                            color: Colors.white,),
                          hintText: "Emailinizi giriniz",
                          labelText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) => !email.contains("@")
                              ? 'Geçersiz email adresi'
                              : null,
                          onSaved: (email) => _email = email),
                      SizedBox(height: 8),
                      LoginTextForm(
                          icon: Icon(Icons.lock,
                            color: Colors.white),
                          hintText: "Şifrenizi giriniz",
                          labelText: "Şifre",
                          obscureText: true,
                          validator: (password) => password.length < 6
                              ? 'En az 6 karakter olmalı'
                              : null,
                          onSaved: (password) => _password = password),
                      SizedBox(height: 8),
                      LoginTextForm(
                          icon: Icon(Icons.lock,
                            color: Colors.white),
                          hintText: "Şifreyi Tekrar Giriniz",
                          labelText: "Şifre Kontrolü",
                          obscureText: true,
                          validator: (passControl) => passControl.length < 6
                              ? 'En az 6 karakter olmalı'
                              : null,
                          onSaved: (passControl) => _passControl = passControl),
                    ],
                  )),
            ),
            SizedBox(height: 8),
             Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
              child: MaterialButton(
                minWidth: 400,
                onPressed: _createAccount,
                height: 50,
                textColor: Colors.black,
                color: Colors.white,
                child: Text(
                  'ÜYE OL',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
