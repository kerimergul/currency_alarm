import 'package:currency_alarm/blocs/alarmpage/bloc.dart';
import 'package:currency_alarm/model/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'alarmListTile.dart';

class AlarmListView extends StatefulWidget {
  final List<Alarm> alarmList;

  const AlarmListView({Key key, @required this.alarmList}) : super(key: key);

  @override
  _AlarmListViewState createState() => _AlarmListViewState();
}

class _AlarmListViewState extends State<AlarmListView> {
  @override
  Widget build(BuildContext context) {
    final _alarmBloc = BlocProvider.of<AlarmBloc>(context);
    final orientation = MediaQuery.of(context).orientation;
    debugPrint("ALARM LIST VIEW ICINDEYIM");

    if (widget.alarmList[0].exchangeTitle == null) {
      return Container(
        child: Center(child: Text("Alarm Listesi Boş")),
      );
    } else {
      return Expanded(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
            itemCount: widget.alarmList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: AlarmListTile(
                  alarm: widget.alarmList[index],
                  onClose: () => {
                    _alarmBloc.dispatch(
                        DeleteAlarmEvent(alarm: widget.alarmList[index])),
                    setState(() {
                      widget.alarmList.removeAt(index);
                    })
                  },
                ),
              );
            }),
      );
    }
  }
}
