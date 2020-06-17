import 'package:currency_alarm/blocs/currency/bloc.dart';
import 'package:currency_alarm/model/currencyDB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_alarm/ui/styles/style.dart';

class CurrencyFavIcon extends StatefulWidget {
  final CurrencyDB currencyItem;

  const CurrencyFavIcon({Key key, @required this.currencyItem})
      : super(key: key);
  @override
  _CurrencyFavIconState createState() => _CurrencyFavIconState();
}

class _CurrencyFavIconState extends State<CurrencyFavIcon> {
  // static int isPressed;
  // @override
  // void initState() {
  //   super.initState();
  //   isPressed = widget.currencyItem.currencyIsFav;
  // }

  @override
  Widget build(BuildContext context) {
    final _currencyBloc = BlocProvider.of<CurrencyBloc>(context);
    return Container(
      child: IconButton(
        icon: Icon(Icons.favorite,
            color: (widget.currencyItem.currencyIsFav == 1) ? favColor : unfavColor),
        onPressed: () {
          setState(() {
            if (widget.currencyItem.currencyIsFav == 1) {
              widget.currencyItem.currencyIsFav = 0;
              _currencyBloc
                  .dispatch(DeleteFavEvent(currency: widget.currencyItem));
            } else if (widget.currencyItem.currencyIsFav == 0) {
              widget.currencyItem.currencyIsFav = 1;
              _currencyBloc
                  .dispatch(AddFavEvent(currency: widget.currencyItem));
            }
          });
        },
      ),
    );
  }
}
