import 'package:currency_alarm/blocs/auth/bloc.dart';
import 'package:currency_alarm/ui/Widgets/common/appbars/appBar.dart';
import 'package:currency_alarm/ui/screens/mainPage.dart';
import 'package:currency_alarm/ui/screens/signInPage.dart';
import 'package:currency_alarm/ui/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'createAccountPage.dart';

class LandingPage extends StatelessWidget {
  final String title;

  LandingPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);
    _guestLogin() {
      _authBloc.dispatch(GuestLoginEvent());
    }

    _loginWithGoogle() {
      _authBloc.dispatch(LoginWithGoogleEvent());
    }

    return Scaffold(
        body: BlocBuilder(
            bloc: _authBloc,
            builder: (context, AuthState state) {
              if (state is AuthInitialState) {
                _authBloc.dispatch(AuthInitialEvent());
                return Center(child: CircularProgressIndicator());
              } else if (state is AuthLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is LoginState) {
                return SignIn(title: title);
              } else if (state is MainpageState) {
                return MainPage(title: title);
              } else if (state is CreateAccountState) {
                return CreateAccountPage();
              } else if (state is LoginErrorState) {
                return Center(
                    child: Container(
                  child: Text(
                    "HATA ÇIKTI: ${state.error.toString()}",
                    style: subTitleStyle,
                  ),
                ));
              } else if (state is LandingPageState) {
                return Scaffold(
                  appBar: CustomAppBar(
                    title: "Merhaba",
                    leftIcon: Icon(Icons.account_box),
                    rightTitle: "Geç",
                    onSkip: _guestLogin,
                  ),
                  body: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  color: bgColor,
                                  child: Center(
                                    child: Text(
                                      "Currency Alarm",
                                      style: titleStyle,
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  color: bgColor,
                                  child: Center(
                                    child: Text(
                                      "Kolayca dövizi takip etmek için alarm kurun.",
                                      style: subTitleStyle,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(height: 60),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
                              child: Container(
                                width: 375,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateAccountPage()));
                                  },
                                  height: 40,
                                  textColor: Colors.black,
                                  color: Colors.white,
                                  child: Text(
                                    'ÜYE OL',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
                              child: Container(
                                width: 375,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignIn()));
                                  },
                                  height: 40,
                                  textColor: Colors.black,
                                  color: Colors.white,
                                  child: Text(
                                    'GİRİŞ YAP',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
                              child: Container(
                                width: 375,
                                child: MaterialButton(
                                  onPressed: _loginWithGoogle,
                                  height: 40,
                                  textColor: Colors.black,
                                  color: Colors.white,
                                  child: Text(
                                    'GMAIL',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                );
              } else {
                return Container();
              }
            }));
  }
}
