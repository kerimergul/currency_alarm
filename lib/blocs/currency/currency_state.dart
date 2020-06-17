import 'package:currency_alarm/model/currencyDB.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CurrencyState extends Equatable {
  CurrencyState([List props = const []]) : super(props);
}

/* CURRENCY PAGE STATES */
class CurrencyInitialState extends CurrencyState {}

class CurrencyLoadingState extends CurrencyState {}

class CurrencyLoadedState extends CurrencyState {
  final List<CurrencyDB> currency;
  CurrencyLoadedState({@required this.currency}) : super([currency]);
}

class CurrencyErrorState extends CurrencyState {
  var error;
  CurrencyErrorState({this.error}) : super([error]);
}

/* FAVORITE METHODS*/
class RemoveFavState extends CurrencyState {}

class AddFavState extends CurrencyState {
  final String itemTitle;
  AddFavState({@required this.itemTitle}) : super([itemTitle]);
}

class DeleteFavState extends CurrencyState {
  final String itemTitle;
  DeleteFavState({@required this.itemTitle}) : super([itemTitle]);
}