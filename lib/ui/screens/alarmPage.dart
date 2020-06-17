import 'package:currency_alarm/blocs/alarmpage/bloc.dart';
import 'package:currency_alarm/ui/screens/alarmLoadedPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    final _alarmBloc = BlocProvider.of<AlarmBloc>(context);

    return BlocBuilder(
        bloc: _alarmBloc,
        builder: (BuildContext context, AlarmState state) {
          if (state is AlarmInitialState) {
            return Center(child: Text("Yenileyiniz."));
          } else if (state is LoadingAlarmState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadedAlarmState) {
            return AlarmLoadedPage(
                currency: state.currency, alarmList: state.alarmList);
          } else if (state is EmptyAlarmState) {
            return AlarmLoadedPage(
              alarmList: state.alarmList,currency: state.currency,
            );
          } else if (state is AlarmErrorState) {
            return Center(
                child: AlertDialog(
                    title: Text("Hata çıktı"),
                    content: Center(
                        child: Container(
                            child: Text("Hata çıktı: ${state.error}")))));
          } else
            return Container();
        });
  }
}
