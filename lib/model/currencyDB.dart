

class CurrencyDB {
  int _currencyID;
  String _currencyTitle;
  String _currencyAlis;
  String _currencySatis;
  String _currencySymbol;
  int _currencyIsFav;
  String _currencyImg;


  int get currencyID => _currencyID;

  set currencyID(int currencyID) {
    _currencyID = currencyID;
  }

  String get currencyTitle => _currencyTitle;

  set currencyTitle(String currencyTitle) {
    _currencyTitle = currencyTitle;
  }

  String get currencyAlis => _currencyAlis;

  set currencyAlis(String currencyAlis) {
    _currencyAlis = currencyAlis;
  }

  String get currencySatis => _currencySatis;

  set currencySatis(String currencySatis) {
    _currencySatis = currencySatis;
  }

  String get currencySymbol => _currencySymbol;

  set currencySymbol(String currencySymbol) {
    _currencySymbol = currencySymbol;
  }

  int get currencyIsFav => _currencyIsFav;

  set currencyIsFav(int currencyIsFav) {
    _currencyIsFav = currencyIsFav;
  }

  String get currencyImg => _currencyImg;

  set currencyImg(String currencyImg) {
    _currencyImg = currencyImg;
  }


  CurrencyDB(this._currencyTitle, this._currencySymbol, this._currencyAlis,
      this._currencySatis, this._currencyIsFav,this._currencyImg);

  CurrencyDB.withID(this._currencyID, this._currencyTitle, this._currencySymbol,
      this._currencyAlis, this._currencySatis, this._currencyIsFav,this._currencyImg);

  CurrencyDB.withoutFav(this._currencyID, this._currencyTitle,
      this._currencySymbol, this._currencyAlis, this._currencySatis,this._currencyImg);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['currencyID'] = currencyID;
    map['currencyTitle'] = currencyTitle;
    map['currencyAlis'] = currencyAlis;
    map['currencySatis'] = currencySatis;
    map['currencySymbol'] = currencySymbol;
    map['currencyImg'] = currencyImg;
    return map;
  }

  CurrencyDB.fromMap(Map<String, dynamic> map) {
    this.currencyID = map['currencyID'];
    this.currencyTitle = map['currencyTitle'];
    this.currencyAlis = map['currencyAlis'];
    this.currencySatis = map['currencySatis'];
    this.currencySymbol = map['currencySymbol'];
    this.currencyIsFav = map['currencyIsFav'];
    this.currencyImg = map['currencyImg'];
  }

  @override
  String toString() {
    return 'Currency {currencyID: $currencyID, currencyTitle: $currencyTitle, currencySymbol: $currencySymbol, currencyAlis: $currencyAlis, currencySatis: $currencySatis, currencyIsFav: $currencyIsFav }';
  }
}
