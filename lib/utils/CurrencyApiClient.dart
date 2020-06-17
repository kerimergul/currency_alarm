import 'dart:async';
import 'dart:convert';
import 'package:currency_alarm/model/currency.dart';
import 'package:xml2json/xml2json.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class CurrencyApiClient {
  Xml2Json xml2json = new Xml2Json();
  final http.Client httpClient = http.Client();
  static const String url = 'https://www.tcmb.gov.tr/kurlar/today.xml';

  Future<Currency> getData() async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception("Döviz Getirilemedi ${response.statusCode}");
      }
      final Xml2Json xml2Json = Xml2Json();
      var raw = xml.parse(response.body);
      xml2Json.parse(raw.toString());
      var jsonString = xml2Json.toParker();
      var data = jsonDecode(jsonString);
      Currency currency = Currency.fromJson(data);
      return currency;
    } catch (e) {
      print(e);
    }
  }
}
