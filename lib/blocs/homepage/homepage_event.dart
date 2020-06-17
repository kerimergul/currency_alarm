import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomepageEvent extends Equatable {
  HomepageEvent([List props = const []]) : super(props);
}


class FetchHomePageEvent extends HomepageEvent {}

