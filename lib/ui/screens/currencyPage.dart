import 'package:currency_alarm/blocs/currency/bloc.dart';
import 'package:currency_alarm/blocs/currency/currency_bloc.dart';
import 'package:currency_alarm/ui/Widgets/common/appbars/appBar.dart';
import 'package:currency_alarm/ui/Widgets/common/currencyListWidgets/currencyListView.dart';
import 'package:currency_alarm/ui/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyPage extends StatefulWidget {
  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  @override
  Widget build(BuildContext context) {
    final _currencyBloc = BlocProvider.of<CurrencyBloc>(context);
    return BlocBuilder(
      bloc: _currencyBloc,
      builder: (context, CurrencyState state) {
        /* INITIAL STATE */
        /*               */
        if (state is CurrencyInitialState) {
          return Center(
              child: Text(
            "Yenileyiniz",
            style: titleStyle,
          ));
          /* LOADING STATE */
          /*               */
        } else if (state is CurrencyLoadingState) {
          return Center(child: CircularProgressIndicator());
        } /* LOADED STATE  */
        /*               */
        else if (state is CurrencyLoadedState) {
          return Scaffold(
            appBar: CustomAppBar(
                title: "Döviz Kurları",
                leftIcon: Icon(Icons.local_atm),
                rightIcon: null,
                onPressed: () => {}),
            body: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: <Widget>[
                  // InfoCurrency(date: time.toIso8601String()),
                  Expanded(child: CurrencyListView(currency: state.currency)),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  )
                ],
              ),
            ),
          );
        } /* ERROR STATE   */
        /*               */
        else if (state is CurrencyErrorState) {
          return Center(
            child: Text("Hata oluştu ${state.error.toString()}"),
          );
        } else if (state is AddFavState) {
          SnackBar snackbar;
          Scaffold.of(context).showSnackBar(snackbar);
        } else if (state is DeleteFavState) {
          SnackBar snackbar;
          Scaffold.of(context).showSnackBar(snackbar);
        }
      },
    );
  }
}
