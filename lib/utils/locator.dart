import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/data/firebase_api/firebase_api.dart';
import 'package:flutter_vietnam_app/data/firebase_api/firebase_api_impl.dart';
import 'package:flutter_vietnam_app/repository/auth_repo/auth_repo.dart';
import 'package:flutter_vietnam_app/repository/auth_repo/auth_repo_impl.dart';
import 'package:flutter_vietnam_app/repository/location_repo/location_repo.dart';
import 'package:flutter_vietnam_app/repository/location_repo/location_repo_impl.dart';
import 'package:flutter_vietnam_app/services/location/location_service.dart';
import 'package:flutter_vietnam_app/services/location/location_service_impl.dart';

import 'package:flutter_vietnam_app/utils/utils_service.dart';

import 'package:flutter_vietnam_app/utils/validation/validate_service_impl.dart';
import 'package:flutter_vietnam_app/utils/validation/validation_service.dart';

import 'package:flutter_vietnam_app/utils/storage/storage_service.dart';
import 'package:flutter_vietnam_app/utils/storage/storage_service_implement.dart';
import 'package:flutter_vietnam_app/view_models/detail_speciality_notifier.dart';
import 'package:flutter_vietnam_app/view_models/listview_location_by_type_notifier.dart';
import 'package:flutter_vietnam_app/view_models/navigation_tab_notifier.dart';
import 'package:flutter_vietnam_app/view_models/post_detail_notifier.dart';
import 'package:flutter_vietnam_app/view_models/search_notifier.dart';
import 'package:flutter_vietnam_app/view_models/wall_notifier.dart';

import '../data/httpie/httpie.dart';

import '../services/auth/auth_service.dart';
import '../services/auth/auth_service_impl.dart';

import 'package:flutter_vietnam_app/view_models/home_notifier.dart';
import 'package:flutter_vietnam_app/view_models/login_notifier.dart';
import 'package:flutter_vietnam_app/view_models/signup_notifier.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;

GetIt serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  serviceLocator.registerLazySingleton<http.Client>(
    () => http.Client(),
  );

  serviceLocator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  serviceLocator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  serviceLocator.registerLazySingleton<UtilsService>(
    () => UtilsService(),
  );
  serviceLocator.registerLazySingleton<ValidationService>(
    () => ValidationServiceImpl(),
  );

  serviceLocator.registerLazySingleton<Httpie>(
    () => HttpieImpl(
      serviceLocator(),
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<FirebaseApi>(
    () => FirebaseApiImpl(
      serviceLocator<FirebaseFirestore>(),
      serviceLocator<FirebaseAuth>(),
    ),
  );

  // service

  serviceLocator.registerLazySingleton<StorageService>(
    () => StorageServiceImpl(),
  );

  await serviceLocator<StorageService>().init();

  serviceLocator.registerLazySingleton<AuthService>(
    () => AuthServiceImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<LocationService>(
    () => LocationServiceImpl(serviceLocator()),
  );

  // repository
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(serviceLocator()),
  );

  // view models
  serviceLocator.registerFactory<SignupScreenViewModel>(
    () => SignupScreenViewModel(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<HomePageViewModel>(
    () => HomePageViewModel(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<LoginScreenViewModel>(
    () => LoginScreenViewModel(
      serviceLocator<AuthRepository>(),
      serviceLocator<ValidationService>(),
    ),
  );

  serviceLocator.registerFactory<NavigationTabViewModel>(
    () => NavigationTabViewModel(),
  );

  serviceLocator.registerFactory<SearchViewModel>(
    () => SearchViewModel(serviceLocator()),
  );

  serviceLocator.registerFactory<WallPageViewModel>(
    () => WallPageViewModel(serviceLocator()),
  );

  serviceLocator.registerFactory<DetailSpecialityViewModel>(
    () => DetailSpecialityViewModel(serviceLocator()),
  );

  serviceLocator.registerFactory<PostDetailViewModel>(
    () => PostDetailViewModel(serviceLocator()),
  );

  serviceLocator.registerFactory<ListviewLocationByTypeNotifer>(
    () => ListviewLocationByTypeNotifer(serviceLocator()),
  );
}
