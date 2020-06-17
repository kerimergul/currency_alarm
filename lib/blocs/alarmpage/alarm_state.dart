import 'package:currency_alarm/model/alarm.dart';
import 'package:currency_alarm/model/currencyDB.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AlarmState extends Equatable {
  AlarmState([List props = const []]) : super(props);
}

/* ALARM PAGE STATES */
class AlarmInitialState extends AlarmState {}


class NotificationState extends AlarmState {
  final List<CurrencyDB> currency;
  NotificationState({@required this.currency}) : super([currency]);
}

class LoadingAlarmState extends AlarmState{}

class EmptyAlarmState extends AlarmState{
  final List<Alarm> alarmList;
  final List<CurrencyDB> currency;
  EmptyAlarmState({@required this.alarmList,@required this.currency}) : super([alarmList,currency]);
}
class LoadedAlarmState extends AlarmState{
  final List<Alarm> alarmList;
  final List<CurrencyDB> currency;
  LoadedAlarmState({@required this.alarmList,@required this.currency}) : super([alarmList,currency]);
}



class AlarmErrorState extends AlarmState{
  final String error;
  AlarmErrorState({@required this.error}) : super([error]);
}

