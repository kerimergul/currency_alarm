import 'package:currency_alarm/model/alarm.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AlarmEvent extends Equatable {
  AlarmEvent([List props = const []]) : super(props);
}

class NotificationEvent extends AlarmEvent {
  // final CurrencyDB currency;

  // NotificationEvent({@required this.currency}) : super([currency]);
}

class AlarmFetchEvent extends AlarmEvent {}

class AddAlarmEvent extends AlarmEvent {
  final Alarm alarm;

  AddAlarmEvent({@required this.alarm}) : super([alarm]);
}

class DeleteAlarmEvent extends AlarmEvent {
   final Alarm alarm;

  DeleteAlarmEvent({@required this.alarm}) : super([alarm]);
}

class NewAlarmEvent extends AlarmEvent {}
