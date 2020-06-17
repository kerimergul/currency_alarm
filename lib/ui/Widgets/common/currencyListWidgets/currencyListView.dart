import 'package:currency_alarm/model/currencyDB.dart';
import 'package:currency_alarm/ui/Widgets/common/currencyListWidgets/currencyListTile.dart';
import 'package:flutter/material.dart';

class CurrencyListView extends StatelessWidget {
  final List<CurrencyDB> currency;

  const CurrencyListView({Key key, @required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(currency.length.toString());
    final int length = 19;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: length,
      reverse: false,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
              child: CurrencyListTile(
            currencyItem: currency[index],
          )),
        );
      },
    );
  }
}
