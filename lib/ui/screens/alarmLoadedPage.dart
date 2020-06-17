import 'package:currency_alarm/model/alarm.dart';
import 'package:currency_alarm/model/currencyDB.dart';
import 'package:currency_alarm/ui/Widgets/common/AlarmListWidgets/alarmListView.dart';
import 'package:currency_alarm/ui/Widgets/common/dialogs/newBuyAlarm.dart';
import 'package:currency_alarm/ui/Widgets/common/dialogs/newSellAlarm.dart';
import 'package:currency_alarm/ui/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AlarmLoadedPage extends StatefulWidget {
  final List<CurrencyDB> currency;
  final List<Alarm> alarmList;

  const AlarmLoadedPage({Key key, this.currency, this.alarmList})
      : super(key: key);
  @override
  _AlarmLoadedPageState createState() => _AlarmLoadedPageState();
}

class _AlarmLoadedPageState extends State<AlarmLoadedPage> {
  _newBuyAlarm() {
    showDialog(
        context: context,
        builder: (context) => new NewBuyAlarm(
              currency: widget.currency,
            ));
  }

  _newSellAlarm() {
    showDialog(
        context: context,
        builder: (context) => new NewSellAlarm(
              currency: widget.currency,
            ));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.alarmList[0].exchangeTitle != "EMPTY") {
      debugPrint("ALARM LIST BUILDDE");
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.alarm),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Alarmlar", style: appBarTitleStyle),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            AlarmListView(alarmList: widget.alarmList),
          ],
        ),
        floatingActionButton: Container(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 36), child: _getFAB()),
      );
    } else {
      debugPrint("EMPTY LIST BUILDDE");
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.alarm),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Alarmlar", style: appBarTitleStyle),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: Container(
              child: Text(
            "Alarm Listeniz Boş",
            style: TextStyle(color: Colors.white),
          )),
        ),
        floatingActionButton: Container(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 42), child: _getFAB()),
      );
    }
  }

  Widget _getFAB() {
    return SpeedDial(
      overlayOpacity: 0,
      elevation: 2,
      animatedIcon: AnimatedIcons.add_event,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: favColor,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            elevation: 2,
            child: Center(
                child: Text("Al",
                    style: TextStyle(color: Colors.white, fontSize: 12))),
            backgroundColor: favColor,
            onTap: _newBuyAlarm,
            // label: 'Alış',
            // labelStyle: TextStyle(
            //     fontWeight: FontWeight.w400,
            //     color: Colors.white,
            //     fontSize: 14.0),
            labelBackgroundColor: bgColor),
        // FAB 2
        SpeedDialChild(
            elevation: 2,
            child: Center(
                child: Text("Sat",
                    style: TextStyle(color: Colors.white, fontSize: 12))),
            backgroundColor: favColor,
            onTap: _newSellAlarm,
            // label: 'Satış',
            // labelStyle: TextStyle(
            //     fontWeight: FontWeight.w400,
            //     color: Colors.black,
            //     fontSize: 14.0),
            labelBackgroundColor: Colors.white)
      ],
    );
  }
}
