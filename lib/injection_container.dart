import 'package:app_movie/features/movie/data/datasources/movie_local_data_source.dart';
import 'package:app_movie/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:app_movie/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:app_movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:app_movie/features/movie/presentation/cubit/movies_cubit.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => NetworkInfo(sl()));

  // Data sources
  sl.registerLazySingleton(() => MovieRemoteDataSource(sl()));
  sl.registerLazySingleton(() => MovieLocalDataSource());

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remote: sl(),
      local: sl(),
      networkInfo: sl(),
    ),
  );

  // Cubit
  sl.registerFactory(() => MoviesCubit(sl()));
}
