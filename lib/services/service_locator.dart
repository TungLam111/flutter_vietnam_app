import 'package:get_it/get_it.dart';

import 'tour/tour_service.dart';
import 'tour/tour_service_implement.dart';

import 'storage/storage_service.dart';
import 'storage/storage_service_implement.dart';

import 'web_httpie/httpie.dart';
import 'web_httpie/httpie_implement.dart';

import 'auth/auth_service.dart';
import 'auth/auth_service_implement.dart';

import '../view_models/login_view_model.dart';
import '../view_models/signup_view_model.dart';

// Using GetIt is a convenient way to provide services and view models
// anywhere we need them in the app.
GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // services
  //serviceLocator.registerLazySingleton<WebApi>(() => WebApiImpl());
  //serviceLocator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  //serviceLocator.registerLazySingleton<CurrencyService>(() => CurrencyServiceImpl());
  //serviceLocator.registerLazySingleton<LoginService>(()=> LoginServiceImpl());
  // You can replace the actual services above with fake implementations during development.
  //
  // serviceLocator.registerLazySingleton<WebApi>(() => FakeWebApi());
  // serviceLocator.registerLazySingleton<StorageService>(() => FakeStorageService());
  // serviceLocator.registerLazySingleton<CurrencyService>(() => CurrencyServiceFake());

  // view models
  //serviceLocator.registerFactory<CalculateScreenViewModel>(() => CalculateScreenViewModel());
  //serviceLocator.registerFactory<FavoriteViewModel>(() => FavoriteViewModel());
  //serviceLocator.registerFactory<LoginScreenViewModel>(() => LoginScreenViewModel());

}