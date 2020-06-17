import 'package:currency_alarm/blocs/homepage/bloc.dart';
import 'package:currency_alarm/ui/screens/landingPage.dart';
import 'package:currency_alarm/ui/styles/style.dart';
import 'package:currency_alarm/utils/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/alarmpage/bloc.dart';
import 'blocs/auth/bloc.dart';
import 'blocs/currency/bloc.dart';
import 'blocs/homepage/homepage_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  // await Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
        builder: (context) => AuthBloc(),
        child: BlocProvider<CurrencyBloc>(
            builder: (context) => CurrencyBloc(),
            child: BlocProvider<HomepageBloc>(
                builder: (context) => HomepageBloc(),
                child: BlocProvider<AlarmBloc>(
                  builder: (context) => AlarmBloc(),
                  child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Currency Alarm',
                      theme: ThemeData(
                        scaffoldBackgroundColor: bgColor,
                        primaryColor: bgColor,
                      ),
                      home: LandingPage(
                        title: 'Currency Alarm',
                      )),
                ))));
  }
}
