import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:currency_alarm/data/currency_repository.dart';
import 'package:currency_alarm/model/currencyDB.dart';
import 'package:currency_alarm/utils/locator.dart';
import 'bloc.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final CurrencyRepository currencyRepository = locator<CurrencyRepository>();
  @override
  HomepageState get initialState => HomepageInitialState();

  @override
  Stream<HomepageState> mapEventToState(
    HomepageEvent event,
  ) async* {
    /* Home Page Event */
    if (event is FetchHomePageEvent) {
      yield HomepageLoadingState();
      try {
        final List<CurrencyDB> favorites =
            await currencyRepository.getFavorite();

        yield HomepageLoadedState(favorite: favorites);
      } catch (_) {
        yield HomepageErrorState(error: _);
      }
    }
  }
}
