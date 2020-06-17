import 'dart:async';
import 'package:currency_alarm/model/alarm.dart';
import 'package:currency_alarm/model/user.dart';
import 'package:currency_alarm/model/currency.dart';
import 'package:currency_alarm/model/currencyDB.dart';
import 'package:currency_alarm/model/symbols.dart';
import 'package:currency_alarm/utils/CurrencyApiClient.dart';
import 'package:currency_alarm/utils/database_helper.dart';
import 'package:currency_alarm/utils/firebaseAuthService.dart';
import 'package:currency_alarm/utils/firestoreService.dart';
import 'package:currency_alarm/utils/locator.dart';
import 'package:flutter/cupertino.dart';

class CurrencyRepository {
  CurrencyApiClient _currencyApiClient = locator<CurrencyApiClient>();
  DatabaseHelper _databaseHelper = locator<DatabaseHelper>();
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FirestoreService _firestoreService = locator<FirestoreService>();

  /// API CLIENT FUNCTIONS
  ///
  ///
  /* FETCHING DATA FROM API CLIENT */
  Future<List<CurrencyDB>> getCurrency() async {
    debugPrint("repo başladı");
    List<CurrencyDB> currencyDB;
    await _currencyApiClient.getData().then((data) {
      currencyDB = getCurrencyDB(data);
    });
    debugPrint(currencyDB[0].currencyAlis + " kontrol");
    return currencyDB;
  }

  /// MODEL FUNCTIONS
  ///
  ///
  /* CREATING NEW CURRENCYDB LIST */
  List<CurrencyDB> _createCurrencyDBList({int itemCount}) {
    List<CurrencyDB> db;

    /* DUMMY FOR NEW LIST */
    if (itemCount == null) {
      db = new List<CurrencyDB>(19);
      int length = 19;
      for (int i = 0; i < length; i++) {
        db[i] = new CurrencyDB.withoutFav(0, "", "", "", "","");
      }
    } else {
      db = new List<CurrencyDB>(itemCount);
      for (int i = 0; i < itemCount; i++) {
        db[i] = new CurrencyDB.withoutFav(0, "", "", "", "","");
      }
    }

    return db;
  }

  /* XML DATA TO CURRENCYDB MODEL*/
  List<CurrencyDB> getCurrencyDB(Currency currency) {
    List<CurrencyDB> db = _createCurrencyDBList();
    int length = 19;

    for (int index = 0; index < length; index++) {
      db[index].currencyID = index + 1;
      db[index].currencyTitle = names[index];
      db[index].currencySymbol = symbols[index];
      db[index].currencyAlis = currency.tarihDate.currency[index].forexBuying;
      db[index].currencySatis = currency.tarihDate.currency[index].forexSelling;
      db[index].currencyImg = flags[index];
    }
    return db;
  }

  /// LOCAL DATABASE FUNCTIONS
  ///
  ///
  /* INSERTING CURRENCY TO DATABASE */
  Future<List<CurrencyDB>> updateCurrency(List<CurrencyDB> currency) async {
    var data = await _databaseHelper.getCurrency();
    for (int i = 0; i < data.length - 1; i++) {
      debugPrint(CurrencyDB.fromMap(data[i]).toString());
    }

    for (int index = 0; index < currency.length - 1; index++) {
      var sonuc = await _databaseHelper.updateCurrency(currency[index]);
      debugPrint("updating all new data " + sonuc.toString());
    }

    var data2 = await _databaseHelper.getCurrency();
    for (int i = 0; i < data.length - 1; i++) {
      currency[i] = CurrencyDB.fromMap(data2[i]);
    }
    return currency;
  }

  Future<List<CurrencyDB>> queryCurrencyDB() async {
    List<CurrencyDB> db = _createCurrencyDBList();
    var data = await _databaseHelper.getCurrency();
    for (int i = 0; i < db.length - 1; i++) {
      db[i] = CurrencyDB.fromMap(data[i]);
    }
    return db;
  }

  /* QUERY FROM FAVORITE DATABASE */
  Future<List<CurrencyDB>> getFavorite() async {
    var mapList = await _databaseHelper.getFavorite();

    List<CurrencyDB> favorite =
        _createCurrencyDBList(itemCount: mapList.length);

    for (int index = 0; index < mapList.length; index++) {
      favorite[index] = CurrencyDB.fromMap(mapList[index]);
    }
    return favorite;
  }

  /* ADDING FAVORITE ITEM TO DATABASE*/
  Future<String> insertFavorite(CurrencyDB currency) async {
    await _databaseHelper.insertFavorite(currency);
    return currency.currencyTitle;
  }

  /* DELETING FAVORITE ITEM FROM DATABASE*/
  Future<String> deleteFavorite(CurrencyDB currency) async {
    await _databaseHelper.deleteFavorite(currency);
    return currency.currencyTitle;
  }

  /// FIREBASE FUNCTIONS
  ///
  ///
  Future<User> signInAnon() async {
    return await _firebaseAuthService.signInAnon();
  }

  Future<bool> signOut() async {
    return await _firebaseAuthService.signOut();
  }

  Future<User> currentUser() async {
    return await _firebaseAuthService.currentUser();
  }

  Future<User> signInWithGoogle() async {
    return await _firebaseAuthService.signInWithGoogle();
  }

  Future<User> signInWithEmail(User user) async {
    return await _firebaseAuthService.signInWithEmail(
        user.userEmail, user.userPassword);
  }

  Future<User> createAccount(User user) async {
    final User _user = await _firebaseAuthService.createAccount(
        user.userEmail, user.userPassword);
    bool result = await _firestoreService.saveUser(_user, user.userPassword);
    if (result) {
      return _user;
    } else {
      return null;
    }
  }

  Future<bool> saveAlarm(String userID, Alarm alarm) async {
    await _firestoreService.saveAlarm(userID, alarm);
    return true;
  }

  Future<bool> deleteAlarm(String userID, Alarm alarm) async {
    final bool result = await _firestoreService.deleteAlarm(userID, alarm);
    return result;
  }

  Future<List<Alarm>> readAlarm(String userID) async {
    final List<Alarm> alarmList = await _firestoreService.readAlarm(userID);
    debugPrint(alarmList[0].exchangeTitle);
    return alarmList;
  }
}
