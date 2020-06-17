import 'package:currency_alarm/blocs/homepage/bloc.dart';
import 'package:currency_alarm/ui/Widgets/common/appbars/appBar.dart';
import 'package:currency_alarm/ui/Widgets/common/currencyListWidgets/currencyListView.dart';
import 'package:currency_alarm/ui/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final _homepageBloc = BlocProvider.of<HomepageBloc>(context);

    return Scaffold(
        body: BlocBuilder(
      bloc: _homepageBloc,
      builder: (context, HomepageState state) {
        /* INITIAL STATE */
        /*               */
        if (state is HomepageInitialState) {
          _homepageBloc.dispatch(FetchHomePageEvent());
          return Center(child: Text("Yenileyiniz"));
          /* LOADING STATE */
          /*               */
        } else if (state is HomepageLoadingState) {
          return Center(child: CircularProgressIndicator());
        } /* LOADED STATE  */
        /*               */
        else if (state is HomepageLoadedState) {
          if (state.favorite.length >= 1) {
            return Scaffold(
              appBar: CustomAppBar(
                title: "Ana Sayfa",
                leftIcon: Icon(Icons.home),
                rightIcon: Icon(Icons.attach_money),
                onPressed: () => {},
              ),
              body: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: <Widget>[
                    Expanded(child: CurrencyListView(currency: state.favorite)),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: CustomAppBar(
                title: "Ana Sayfa",
                leftIcon: Icon(Icons.home),
                rightIcon: Icon(Icons.attach_money),
                onPressed: () => {},
              ),
              body: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                    child: Text(
                  "Favori Listesi Boş",
                  style: subTitleStyle,
                )),
              ),
            );
          }
        } /* ERROR STATE   */
        /*               */
        else if (state is HomepageErrorState) {
          return Center(
            child: Text("Hata oluştu ${state.error.toString()}"),
          );
        }
      },
    ));
  }
}
