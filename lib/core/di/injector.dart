import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/movies/data/repositories/movie_repository_impl.dart';
import '../../features/movies/domain/repositories/movie_repository.dart';
import '../../features/movies/domain/usecases/get_movies_usecase.dart';
import '../../features/movies/presentation/bloc/movie_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Регистрация Dio
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/',
        connectTimeout: Duration(seconds: 3),
        receiveTimeout: Duration(seconds: 2),
      )));

  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/',
    connectTimeout: Duration(seconds: 3),
    receiveTimeout: Duration(seconds: 2),
  ))
    ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getIt<Dio>()));

  getIt.registerLazySingleton(() => GetMoviesUseCase(getIt<MovieRepository>()));

  getIt.registerFactory(() => MovieBloc(getIt<GetMoviesUseCase>()));
}
