import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:currency_alarm/data/currency_repository.dart';
import 'package:currency_alarm/model/currencyDB.dart';
import 'package:currency_alarm/utils/locator.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository currencyRepository = locator<CurrencyRepository>();
  @override
  CurrencyState get initialState => CurrencyInitialState();

  @override
  Stream<CurrencyState> mapEventToState(
    CurrencyEvent event,
  ) async* {
    /* FETCHING CURRENCY FROM XML */
    if (event is FetchCurrencyEvent) {
      yield CurrencyLoadingState();
      try {
        // await Workmanager.registerOneOffTask("1", "TaskCurrency");
        
        List<CurrencyDB> currencyDB;
        List<CurrencyDB> currency;

        currencyDB = await currencyRepository.getCurrency();
        debugPrint("data blocta");

        await currencyRepository.updateCurrency(currencyDB);
        debugPrint("sonuc blocta");
        currency = await currencyRepository.queryCurrencyDB();

        yield CurrencyLoadedState(currency: currency);
      } catch (_) {
        yield CurrencyErrorState(error: _);
      }
    }

    /* ADDING FAVORITE TO DATABASE */
    else if (event is AddFavEvent) {
      debugPrint("addfav event");
      try {
        String itemTitle =
            await currencyRepository.insertFavorite(event.currency);
        debugPrint("favoriye eklendi " + itemTitle);
      } catch (_) {
        yield currentState;
      }
    }
    /* DELETING FAVORITE FROM DATABASE */
    else if (event is DeleteFavEvent) {
      try {
        String itemTitle =
            await currencyRepository.deleteFavorite(event.currency);
        debugPrint("favoriden silindi " + itemTitle);
      } catch (_) {
        yield currentState;
      }
    }
  }
}
