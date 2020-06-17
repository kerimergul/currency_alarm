import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

/* Homepage States */

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class LoginState extends AuthState {}

class LoginErrorState extends AuthState {
  var error;
  LoginErrorState({this.error}) : super([error]);
}

class MainpageState extends AuthState {}

class CreateAccountState extends AuthState {}

class LandingPageState extends AuthState {}
