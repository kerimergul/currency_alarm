import 'package:currency_alarm/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class CreateAccountEvent extends AuthEvent {
  final User user;

  CreateAccountEvent({@required this.user}) : super([user]);
}

class MainpageEvent extends AuthEvent {}

class SignInPage extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class GuestLoginEvent extends AuthEvent {}

class LoginWithGoogleEvent extends AuthEvent {}

class CreateScreenEvent extends AuthEvent {}

class SingInWithEmailEvent extends AuthEvent {
  final User user;

  SingInWithEmailEvent({@required this.user}) : super([user]);
}
