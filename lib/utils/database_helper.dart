import 'dart:async';
import 'dart:io';
import 'package:currency_alarm/model/currencyDB.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "currencyDB.db");
    print(path.toString());

    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
        print(_);
      }

      ByteData data = await rootBundle.load(join("assets", "currencyDB.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    return await openDatabase(path, readOnly: false);
  }

  /* CURRENCY TABLE METHODLARI */
  /*                           */
  Future<List<Map<String, dynamic>>> getCurrency() async {
    var db = await _getDatabase();
    var currency = await db.query("currency", orderBy: 'currencyID ASC');
    return currency;
  }

  Future<int> insertCurrency(CurrencyDB currency) async {
    var db = await _getDatabase();
    var sonuc = await db.insert("currency", currency.toMap());
    return sonuc;
  }

  Future<int> updateCurrency(CurrencyDB currency) async {
    var db = await _getDatabase();
    var sonuc = await db.update("currency", currency.toMap(),
        where: "currencyID= ?", whereArgs: [currency.currencyID]);

    return sonuc;
  }

  Future<int> deleteCurrency() async {
    var db = await _getDatabase();
    var sonuc = await db.delete("currency");
    return sonuc;
  }

  /* FAVORITE TABLE METHODLARI */
  /*                           */
  Future<List<Map<String, dynamic>>> getFavorite() async {
    var db = await _getDatabase();
    var favorite =
        db.rawQuery('SELECT * FROM currency WHERE currencyIsFav=?', ['1']);
    print(favorite);
    return favorite;
  }

  Future<int> insertFavorite(CurrencyDB currency) async {
    currency.currencyIsFav = 1;
    var db = await _getDatabase();
    var sonuc = await db.rawUpdate(
        'UPDATE currency SET currencyIsFav = ${currency.currencyIsFav} WHERE currencyID = ${currency.currencyID}');
    return sonuc;
  }

  Future<int> deleteFavorite(CurrencyDB currency) async {
    currency.currencyIsFav = 0;
    var db = await _getDatabase();
    var sonuc = await db.rawUpdate(
        'UPDATE currency SET currencyIsFav = ${currency.currencyIsFav} WHERE currencyID = ${currency.currencyID}');
    return sonuc;
  }
}
