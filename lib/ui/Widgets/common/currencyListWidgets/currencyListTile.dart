import 'package:currency_alarm/model/currencyDB.dart';
import 'package:currency_alarm/ui/Widgets/common/currencyListWidgets/currencyFavIcon.dart';
import 'package:currency_alarm/ui/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CurrencyListTile extends StatelessWidget {
  final CurrencyDB currencyItem;
  

  const CurrencyListTile({
    Key key,
    @required this.currencyItem,
  }) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     elevation: 1.0,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         Container(
  //           width: 50.0,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //               Text("${currencyItem.currencyTitle}"),
  //               Text("${currencyItem.currencySymbol}")
  //             ],
  //           ),
  //         ),
  //         Container(
  //             child: Text(
  //                 "${currencyItem.currencyAlis}        ${currencyItem.currencySatis} ")),
  //         CurrencyFavIcon(currencyItem: currencyItem),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: lightColor.withOpacity(0.1),
              offset: Offset(-6, -6),
              spreadRadius: 0,
              blurRadius: 6,
            ),
            BoxShadow(
              color: Colors.black26,
              offset: Offset(6, 6),
              spreadRadius: 0,
              blurRadius: 6,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(currencyItem.currencyImg),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 16, 14, 16),
            child: Center(
              child: Text(
                "${currencyItem.currencySymbol}",
                style: titleStyle,
              ),
            ),
          ),
          Container(
              child: Center(
            child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text("Alış : ${currencyItem.currencyAlis} ₺",
                        style: subTitleStyle),
                  )),
              Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text("Satış : ${currencyItem.currencySatis} ₺",
                        style: subTitleStyle),
                  )),
            ]),
          )),
          CurrencyFavIcon(currencyItem: currencyItem)
        ],
      ),
    );
  }
}
