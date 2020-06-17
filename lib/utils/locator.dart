import 'package:currency_alarm/utils/CurrencyApiClient.dart';
import 'package:currency_alarm/data/currency_repository.dart';
import 'package:currency_alarm/utils/NotificationManager.dart';
import 'package:currency_alarm/utils/database_helper.dart';
import 'package:currency_alarm/utils/firestoreService.dart';
import 'package:get_it/get_it.dart';

import 'firebaseAuthService.dart';

GetIt locator=GetIt();

void setupLocator(){
  locator.registerLazySingleton(() =>CurrencyRepository());
  locator.registerLazySingleton(() =>CurrencyApiClient());
  locator.registerLazySingleton(() =>DatabaseHelper());
  locator.registerLazySingleton(() =>NotificationManager());
  locator.registerLazySingleton(()=> FirebaseAuthService());
  locator.registerLazySingleton(()=> FirestoreService());
}