import 'package:currency_alarm/model/currencyDB.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CurrencyEvent extends Equatable {
  CurrencyEvent([List props = const []]) : super(props);
}

class FetchCurrencyEvent extends CurrencyEvent {}

class AddFavEvent extends CurrencyEvent {
  final CurrencyDB currency;

  AddFavEvent({@required this.currency}) : super([currency]);
}

class DeleteFavEvent extends CurrencyEvent {
final CurrencyDB currency;

DeleteFavEvent({@required this.currency}) : super([currency]);
}

class RefreshCurrencyEvent extends CurrencyEvent {}

