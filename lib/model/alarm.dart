class Alarm {
  final String exchangeTitle;
  final String exchangeSymbol;
  String exchangeValue;
  String exchangeType;
  String exchangeImg;

  Alarm(this.exchangeTitle, this.exchangeValue, this.exchangeSymbol,
      this.exchangeType, this.exchangeImg);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['exchangeValue'] = exchangeValue;
    map['exchangeType'] = exchangeType;
    map['exchangeTitle'] = exchangeTitle;
    map['exchangeSymbol'] = exchangeSymbol;
    map['exchangeImg'] = exchangeImg;
    return map;
  }

  Map<String, dynamic> toMapWithUserID(String userID) {
    var map = Map<String, dynamic>();
    map['userID'] = userID;
    map['exchangeValue'] = exchangeValue;
    map['exchangeType'] = exchangeType;
    map['exchangeTitle'] = exchangeTitle;
    map['exchangeSymbol'] = exchangeSymbol;
    map['exchangeImg'] = exchangeImg;
    return map;
  }

  Alarm.fromMap(Map<String, dynamic> map)
      : exchangeTitle = map['exchangeTitle'],
        exchangeSymbol = map['exchangeSymbol'],
        exchangeValue = map['exchangeValue'],
        exchangeImg = map['exchangeImg'],
        exchangeType = map['exchangeType'];
}
