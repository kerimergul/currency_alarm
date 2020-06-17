import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:currency_alarm/data/currency_repository.dart';
import 'package:currency_alarm/model/user.dart';
import 'package:currency_alarm/utils/locator.dart';
import 'package:flutter/foundation.dart';
import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CurrencyRepository currencyRepository = locator<CurrencyRepository>();

  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    /* AUTH Event */
    if (event is AuthInitialEvent) {
      yield AuthLoadingState();
      try {
        final User _user = await currencyRepository.currentUser();
        if (_user == null) {
          yield LandingPageState();
        } else {
          yield MainpageState();
        }
      } catch (_) {
        yield LoginErrorState(error: _);
      }
    } else if (event is LoginWithGoogleEvent) {
      yield AuthLoadingState();
      try {
        final User _user = await currencyRepository.signInWithGoogle();
        yield MainpageState();
      } catch (_) {
        yield LoginErrorState(error: _);
      }
    } else if (event is LogoutEvent) {
      yield AuthLoadingState();
      try {
        await currencyRepository.signOut();
        yield LandingPageState();
      } catch (_) {
        yield LoginErrorState(error: _);
      }
    } else if (event is GuestLoginEvent) {
      yield AuthLoadingState();
      try {
        final User _user = await currencyRepository.signInAnon();
        yield MainpageState();
      } catch (_) {
        yield LoginErrorState(error: _);
      }
    } else if (event is CreateAccountEvent) {
      try {
        final User _userCheck = await currencyRepository.createAccount(event.user);
        final User _user = await currencyRepository.currentUser();
        debugPrint(_userCheck.userEmail);
        if (_userCheck.userID != null) {
          yield MainpageState();
        } else {
          yield LoginState();
        }
      } catch (_) {
        yield LoginErrorState(error: _);
      }
    } else if (event is SingInWithEmailEvent) {
      yield AuthLoadingState();
      try {
        final User _user = await currencyRepository.signInWithEmail(event.user);
        if (_user != null) {
          yield MainpageState();
        } else {
          yield LoginState();
        }
      } catch (_) {
        yield LoginErrorState(error: _);
      }
    } else if (event is CreateScreenEvent) {
      yield CreateAccountState();
    }
  }
}
