import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:currency_alarm/data/currency_repository.dart';
import 'package:currency_alarm/model/alarm.dart';
import 'package:currency_alarm/model/currencyDB.dart';
import 'package:currency_alarm/model/user.dart';
import 'package:currency_alarm/utils/locator.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  final CurrencyRepository currencyRepository = locator<CurrencyRepository>();
  @override
  AlarmState get initialState => AlarmInitialState();

  @override
  Stream<AlarmState> mapEventToState(
    AlarmEvent event,
  ) async* {
    /* NOTIFICATION EVENT */
    if (event is NotificationEvent) {
      //  await currencyRepository.callbackDispatcher();
    } else if (event is AddAlarmEvent) {
      try {
        final User user = await currencyRepository.currentUser();
        await currencyRepository.saveAlarm(user.userID, event.alarm);
        debugPrint(user.userEmail);
        final List<Alarm> alarmList =
            await currencyRepository.readAlarm(user.userID);
        final List<CurrencyDB> currency =
            await currencyRepository.queryCurrencyDB();
        yield LoadedAlarmState(alarmList: alarmList, currency: currency);
      } catch (_) {
        yield AlarmErrorState(error: _.toString());
      }
    } else if (event is DeleteAlarmEvent) {
      try {
        debugPrint("DELETE  ALARM ");
        final User user = await currencyRepository.currentUser();
        await currencyRepository.deleteAlarm(user.userID, event.alarm);
        debugPrint(user.userEmail);
        final List<Alarm> alarmList =
            await currencyRepository.readAlarm(user.userID);
        final List<CurrencyDB> currency =
            await currencyRepository.queryCurrencyDB();
        yield LoadedAlarmState(alarmList: alarmList, currency: currency);
      } catch (_) {
        yield AlarmErrorState(error: _.toString());
      }
    } else if (event is AlarmFetchEvent) {
      yield LoadingAlarmState();
      try {
        final List<CurrencyDB> currency =
            await currencyRepository.queryCurrencyDB();
        final User user = await currencyRepository.currentUser();
        final List<Alarm> alarmList =
            await currencyRepository.readAlarm(user.userID);
        debugPrint(alarmList[0].exchangeTitle);
        if (alarmList[0].exchangeTitle != "EMPTY") {
          yield LoadedAlarmState(alarmList: alarmList, currency: currency);
        } else {
          debugPrint("EMPTY ALARM ");
          yield EmptyAlarmState(alarmList: alarmList, currency: currency);
        }
      } catch (_) {
        yield AlarmErrorState(error: _.toString());
      }
    }
  }
}
