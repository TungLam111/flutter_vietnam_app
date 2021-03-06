import 'package:get_it/get_it.dart';

import 'storage/storage_service.dart';
import 'storage/storage_service_implement.dart';

import 'web_httpie/httpie.dart';
import 'web_httpie/httpie_implement.dart';

import 'auth/auth_service.dart';
import 'auth/auth_service_implement.dart';

// Using GetIt is a convenient way to provide services and view models
// anywhere we need them in the app.
GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {

  serviceLocator.registerLazySingleton<Httpie>(() => HttpieService());
  serviceLocator.registerLazySingleton<Store>(() => SystemPreferencesStorage());
  serviceLocator.registerLazySingleton<Auth>(()=> AuthApiService());
  
  // view models
  //serviceLocator.registerFactory<CalculateScreenViewModel>(() => CalculateScreenViewModel());
  //serviceLocator.registerFactory<FavoriteViewModel>(() => FavoriteViewModel());
  //serviceLocator.registerFactory<LoginScreenViewModel>(() => LoginScreenViewModel());

}