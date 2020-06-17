import 'package:currency_alarm/blocs/alarmpage/bloc.dart';
import 'package:currency_alarm/model/alarm.dart';
import 'package:currency_alarm/model/currencyDB.dart';
import 'package:currency_alarm/model/symbols.dart';
import 'package:currency_alarm/ui/Widgets/common/formFields/loginTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewBuyAlarm extends StatefulWidget {
  final List<CurrencyDB> currency;

  const NewBuyAlarm({Key key, this.currency}) : super(key: key);
  @override
  _NewAlarmState createState() => _NewAlarmState();
}

class _NewAlarmState extends State<NewBuyAlarm> {
  int selectedValue;
  List<String> currencyNames = new List<String>(19);
  final _formBuy = GlobalKey<FormState>();
  String selectedName;
  String _buy;
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
        int valueIndex = names.indexOf(selectedName);

        debugPrint("Buy: $_buy Döviz: $selectedName");
        final Alarm _alarm = new Alarm(
            selectedName, _buy, widget.currency[valueIndex].currencySymbol,"BUY",flags[valueIndex]);
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
