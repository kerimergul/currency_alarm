import 'package:currency_alarm/blocs/alarmpage/bloc.dart';
import 'package:currency_alarm/model/alarm.dart';
import 'package:currency_alarm/model/currencyDB.dart';
import 'package:currency_alarm/model/symbols.dart';
import 'package:currency_alarm/ui/Widgets/common/formFields/loginTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewSellAlarm extends StatefulWidget {
  final List<CurrencyDB> currency;

  const NewSellAlarm({Key key, this.currency}) : super(key: key);
  @override
  _NewAlarmState createState() => _NewAlarmState();
}

class _NewAlarmState extends State<NewSellAlarm> {
  int selectedValue;
  List<String> currencyNames = new List<String>(19);
  final _formSell = GlobalKey<FormState>();
  String selectedName;
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
      if (_formSell.currentState.validate()) {
        _formSell.currentState.save();
        debugPrint("Buy: $_sell Döviz: $selectedName");
        int valueIndex = names.indexOf(selectedName);
        final Alarm _alarm = Alarm(
            selectedName,
            _sell,
            widget.currency[valueIndex].currencySymbol,
            "SELL",
            flags[valueIndex]);
        _alarmBloc.dispatch(AddAlarmEvent(alarm: _alarm));
        Navigator.pop(context);
      }
    }

    return SimpleDialog(
      title: Text("Yeni Alarm"),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formSell,
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
                      labelText: "Satış Değeri",
                      hintText: "Sayı giriniz",
                      keyboardType: TextInputType.number,
                      errorText: _errorText,
                      onSaved: (selling) => _sell = selling),
                ),
              ])),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("İptal")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(onPressed: _buyPressed, child: Text("Tamam")),
            ),
          ],
        )
      ],
    );
  }
}
