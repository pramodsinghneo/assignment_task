import 'package:assignment_task/core/network_helper/network_helper.dart';
import 'package:assignment_task/core/network_info/network_info.dart';
import 'package:assignment_task/data/remote_datasource.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future serviceLocator() async {
  locator.registerLazySingleton<Connectivity>(() => Connectivity());
  // locator.registerLazySingleton<DataConnectionChecker>(
  //     () => DataConnectionChecker());
  locator.registerLazySingleton<Dio>(() => Dio(BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      receiveDataWhenStatusError: true)));
  locator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: locator()));
  locator.registerLazySingleton<NetworkHelper>(() => NetworkHelper(
        dio: locator(),
        networkInfo: locator(),
      ));
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource());
}
