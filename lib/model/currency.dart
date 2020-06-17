import 'dart:convert';

Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));

String currencyToJson(Currency data) => json.encode(data.toJson());

class Currency {
    TarihDate tarihDate;

    Currency({
        this.tarihDate,
    });

    factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        tarihDate: json["Tarih_Date"] == null ? null : TarihDate.fromJson(json["Tarih_Date"]),
    );

    Map<String, dynamic> toJson() => {
        "Tarih_Date": tarihDate == null ? null : tarihDate.toJson(),
    };
}

class TarihDate {
    List<CurrencyElement> currency;
    String tarih;
    String date;
    String bultenNo;

    TarihDate({
        this.currency,
        this.tarih,
        this.date,
        this.bultenNo,
    });

    factory TarihDate.fromJson(Map<String, dynamic> json) => TarihDate(
        currency: json["Currency"] == null ? null : List<CurrencyElement>.from(json["Currency"].map((x) => CurrencyElement.fromJson(x))),
        tarih: json["Tarih"] == null ? null : json["Tarih"],
        date: json["Date"] == null ? null : json["Date"],
        bultenNo: json["_Bulten_No"] == null ? null : json["Bulten_No"],
    );

    Map<String, dynamic> toJson() => {
        "Currency": currency == null ? null : List<dynamic>.from(currency.map((x) => x.toJson())),
        "Tarih": tarih == null ? null : tarih,
        "Date": date == null ? null : date,
        "Bulten_No": bultenNo == null ? null : bultenNo,
    };
}

class CurrencyElement {
    String unit;
    String isim;
    String currencyName;
    String forexBuying;
    String forexSelling;
    String banknoteBuying;
    String banknoteSelling;
    String crossRateUsd;
    String crossRateOther;
    String crossOrder;
    String kod;
    String currencyCode;
     


    CurrencyElement({
        this.unit,
        this.isim,
        this.currencyName,
        this.forexBuying,
        this.forexSelling,
        this.banknoteBuying,
        this.banknoteSelling,
        this.crossRateUsd,
        this.crossRateOther,
        this.crossOrder,
        this.kod,
        this.currencyCode,
    });

    factory CurrencyElement.fromJson(Map<String, dynamic> json) => CurrencyElement(
        unit: json["Unit"] = json["Unit"],
        isim: json["Isim"] = json["Isim"],
        currencyName: json["CurrencyName"] = json["CurrencyName"],
        forexBuying: json["ForexBuying"] = json["ForexBuying"],
        forexSelling: json["ForexSelling"] = json["ForexSelling"],
        banknoteBuying: json["BanknoteBuying"] = json["BanknoteBuying"],
        banknoteSelling: json["BanknoteSelling"] = json["BanknoteSelling"],
        crossRateUsd: json["CrossRateUSD"] = json["CrossRateUSD"],
        crossRateOther: json["CrossRateOther"] = json["CrossRateOther"],
        crossOrder: json["CrossOrder"] = json["CrossOrder"],
        kod: json["Kod"] = json["Kod"],
        currencyCode: json["CurrencyCode"] = json["CurrencyCode"],
    );

    Map<String, dynamic> toJson() => {
        "Unit": unit == null ? null : unit,
        "Isim": isim == null ? null : isim,
        "CurrencyName": currencyName == null ? null : currencyName,
        "ForexBuying": forexBuying == null ? null : forexBuying,
        "ForexSelling": forexSelling == null ? null : forexSelling,
        "BanknoteBuying": banknoteBuying == null ? null : banknoteBuying,
        "BanknoteSelling": banknoteSelling == null ? null : banknoteSelling,
        "CrossRateUSD": crossRateUsd == null ? null : crossRateUsd,
        "CrossRateOther": crossRateOther == null ? null : crossRateOther,
        "CrossOrder": crossOrder == null ? null : crossOrder,
        "Kod": kod == null ? null : kod,
        "CurrencyCode": currencyCode == null ? null : currencyCode,
    };
}
