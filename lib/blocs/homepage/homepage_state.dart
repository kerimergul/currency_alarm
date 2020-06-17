import 'package:currency_alarm/model/currencyDB.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomepageState extends Equatable {
  HomepageState([List props = const []]) : super(props);
}

/* Homepage States */

class HomepageInitialState extends HomepageState {}

class HomepageLoadingState extends HomepageState {}

class HomepageLoadedState extends HomepageState {
  final List<CurrencyDB> favorite;

  HomepageLoadedState({@required this.favorite});
}

class HomepageErrorState extends HomepageState {
  var error;
  HomepageErrorState({this.error}) : super([error]);
}
