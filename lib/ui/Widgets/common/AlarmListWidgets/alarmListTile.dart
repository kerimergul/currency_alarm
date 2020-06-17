import 'package:currency_alarm/model/alarm.dart';
import 'package:currency_alarm/model/symbols.dart';
import 'package:currency_alarm/ui/styles/style.dart';
import 'package:flutter/material.dart';


class AlarmListTile extends StatelessWidget {
  final Alarm alarm;
  final Function onClose;

  const AlarmListTile({Key key, this.alarm, this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 100,
      width: 160,
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: lightColor.withOpacity(0.1),
              offset: Offset(-6, -6),
              spreadRadius: 0,
              blurRadius: 6,
            ),
            BoxShadow(
              color: Colors.black26,
              offset: Offset(6, 6),
              spreadRadius: 0,
              blurRadius: 6,
            )
          ]),
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(alarm.exchangeImg != null
                        ? alarm.exchangeImg
                        : flags[0]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
              child: Center(
                child: Text(
                  "${alarm.exchangeSymbol}",
                  style: titleStyle,
                ),
              ),
            ),
            SizedBox(),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: onClose,
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Text(
                      alarm.exchangeType == "BUY"
                          ? "Alış Alarmı : "
                          : "Satış Alarmı :",
                      style: subTitleStyle),
                )),
            Container(
                padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                child: Center(
                  child: Text("${alarm.exchangeValue}", style: subTitleStyle),
                )),
          ]),
          Container(
              child: Center(
            child: FlatButton(
              onPressed: () => {},
              color: Colors.transparent,
              child: Text("Düzenle",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400)),
            ),
          ))
        ],
      ),
    );
  }
}
