import 'package:currency_alarm/blocs/alarmpage/bloc.dart';
import 'package:currency_alarm/model/alarm.dart';
import 'package:currency_alarm/model/currencyDB.dart';
import 'package:currency_alarm/model/symbols.dart';
import 'package:currency_alarm/ui/Widgets/common/formFields/loginTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewAlarm extends StatefulWidget {
  final List<CurrencyDB> currency;

  const NewAlarm({Key key, this.currency}) : super(key: key);
  @override
  _NewAlarmState createState() => _NewAlarmState();
}

class _NewAlarmState extends State<NewAlarm> {
  int selectedValue;
  List<String> currencyNames = new List<String>(19);
  final _formBuy = GlobalKey<FormState>();
  final _formSell = GlobalKey<FormState>();
  String selectedName;
  String _buy;
  String _sell;
  String _errorText;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.currency.length; i++) {
      currencyNames[i] = widget.currency[i].currencyTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _alarmBloc = BlocProvider.of<AlarmBloc>(context);

    _buyPressed() {
      if (_formBuy.currentState.validate()) {
        _formBuy.currentState.save();
        debugPrint("Buy: $_buy  Sell: $_sell  Döviz: $selectedName");
        final Alarm _alarm = Alarm(
            widget.currency[selectedValue].currencyTitle,
            widget.currency[selectedValue].currencySymbol,
            _buy,
            _sell,
            flags[selectedValue]);
        _alarmBloc.dispatch(AddAlarmEvent(alarm: _alarm));
      }
    }

    _sellPressed() {
      if (_formSell.currentState.validate()) {
        _formSell.currentState.save();
        debugPrint("Buy: $_buy  Sell: $_sell  Döviz: $selectedName");
        final Alarm _alarm = Alarm(
            widget.currency[selectedValue].currencyTitle,
            widget.currency[selectedValue].currencySymbol,
            _buy,
            _sell,
            flags[selectedValue]);
        _alarmBloc.dispatch(AddAlarmEvent(alarm: _alarm));
      }
    }

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: "Alış"),
                  Tab(text: "Satış"),
                ],
              ),
              title: Text('Yeni Alarm'),
            ),
            body: TabBarView(children: <Widget>[
              Column(children: <Widget>[
                Form(
                    key: _formBuy,
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new DropdownButton<String>(
                          hint: Text("Lütfen Döviz Seçiniz"),
                          value: selectedName,
                          onChanged: ((String value) {
                            setState(() {
                              selectedName = value;
                            });
                          }),
                          items: currencyNames.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LoginTextForm(
                            labelText: "Alış Değeri",
                            hintText: "Sayı giriniz",
                            keyboardType: TextInputType.number,
                            errorText: _errorText,
                            onSaved: (buying) => _buy = buying),
                      ),
                    ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                          onPressed: _buyPressed, child: Text("Tamam")),
                    ),
                  ],
                )
              ]),
              Column(children: <Widget>[
                Form(
                    key: _formSell,
                    child: Column(children: <Widget>[
                      new DropdownButton<String>(
                        hint: Text("Lütfen Döviz Seçiniz"),
                        value: selectedName,
                        onChanged: ((String value) {
                          setState(() {
                            selectedName = value;
                          });
                        }),
                        items: currencyNames.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LoginTextForm(
                            labelText: "Satış Değeri",
                            hintText: "Sayı giriniz",
                            keyboardType: TextInputType.number,
                            onSaved: (selling) => _sell = selling),
                      ),
                    ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                          onPressed: _sellPressed, child: Text("Tamam")),
                    ),
                  ],
                )
              ])
            ])));
  }
}
