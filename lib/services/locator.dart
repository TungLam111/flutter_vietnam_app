import 'package:flutter_vietnam_app/services/location/location_service.dart';
import 'package:flutter_vietnam_app/services/location/location_service_impl.dart';
import 'package:flutter_vietnam_app/services/media/media.dart';
import 'package:flutter_vietnam_app/services/media/media_impl.dart';
import 'package:flutter_vietnam_app/services/service.dart';
import 'package:flutter_vietnam_app/services/service_impl.dart';
import 'package:flutter_vietnam_app/services/validation/validate_service_impl.dart';
import 'package:flutter_vietnam_app/services/validation/validation_service.dart';
import 'package:flutter_vietnam_app/view_models/home_view_model.dart';
import 'package:flutter_vietnam_app/view_models/login_view_model.dart';
import 'package:flutter_vietnam_app/view_models/signup_view_model.dart';
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
  serviceLocator.registerLazySingleton<LocationService>(() => LocationApiService());
  serviceLocator.registerLazySingleton<ServiceMain>(() => Service());
  serviceLocator.registerLazySingleton<MediaService>(() => MediaServiceImpl());
  serviceLocator.registerLazySingleton<ValidationService>(() => ValidationServiceImpl());
  // view models
  serviceLocator.registerFactory<SignupScreenViewModel>(() => SignupScreenViewModel());
  serviceLocator.registerFactory<HomePageViewModel>(() => HomePageViewModel());
  serviceLocator.registerFactory<LoginScreenViewModel>(() => LoginScreenViewModel());

}