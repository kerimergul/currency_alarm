import 'package:currency_alarm/blocs/auth/bloc.dart';
import 'package:currency_alarm/ui/Widgets/common/appbars/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);
    _logOut() {
      _authBloc.dispatch(LogoutEvent());
    }

    return Scaffold(
        appBar: CustomAppBar(
            title: "Ayarlar",
            leftIcon: Icon(Icons.settings),
            rightIcon: Icon(Icons.exit_to_app),
            onPressed: _logOut),
        body: Container());
  }
}
