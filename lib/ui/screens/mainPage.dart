import 'package:currency_alarm/blocs/alarmpage/bloc.dart';
import 'package:currency_alarm/blocs/auth/bloc.dart';
import 'package:currency_alarm/blocs/currency/bloc.dart';
import 'package:currency_alarm/blocs/homepage/bloc.dart';
import 'package:currency_alarm/ui/Widgets/bottomNavBar/bottomNavBar.dart';
import 'package:currency_alarm/ui/Widgets/bottomNavBar/bottomTabItems.dart';
import 'package:currency_alarm/ui/screens/settingsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'alarmPage.dart';
import 'currencyPage.dart';
import 'homePage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title, this.user}) : super(key: key);
  final String title;
  final FirebaseUser user;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TabItem _currentTab = TabItem.Homepage;
  Map<TabItem, Widget> navPages() {
    return {
      TabItem.Homepage: Homepage(),
      TabItem.Alarms: AlarmPage(),
      TabItem.Currency: CurrencyPage(),
      TabItem.Settings: SettingsPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final _currencyBloc = BlocProvider.of<CurrencyBloc>(context);
    final _homepageBloc = BlocProvider.of<HomepageBloc>(context);
    final _alarmBloc = BlocProvider.of<AlarmBloc>(context);

    return Scaffold(
        body: Container(
      child: BottomNavBar(
        currentTab: _currentTab,
        pageBuilder: navPages(),
        onSelectedTab: (selectedTab) {
          setState(() {
            _currentTab = selectedTab;
          });
          print("SELECTED" + selectedTab.toString());
          if (_currentTab == TabItem.Homepage) {
            _homepageBloc.dispatch(FetchHomePageEvent());
          } else if (_currentTab == TabItem.Alarms) {
            _alarmBloc.dispatch(AlarmFetchEvent());
          } else if (_currentTab == TabItem.Currency) {
            _currencyBloc.dispatch(FetchCurrencyEvent());
            debugPrint("currency secildi");
          } else if (_currentTab == TabItem.Settings) {
            // _newsBloc.dispatch(FetchNewsEvent());

          }
        },
      ),
    ));
  }
}
