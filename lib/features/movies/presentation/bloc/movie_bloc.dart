import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/features/movies/domain/entities/movie.dart';
import 'package:movie_finder/features/movies/domain/usecases/get_movies_usecase.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MultiCategoryMovieState extends MovieState {
  final Map<String, List<Movie>> moviesByCategory;
  final Set<String> loadingCategories;
  final Map<String, String> errorMessages;

  MultiCategoryMovieState({
    required this.moviesByCategory,
    required this.loadingCategories,
    required this.errorMessages,
  });

  factory MultiCategoryMovieState.initial() {
    return MultiCategoryMovieState(
      moviesByCategory: {},
      loadingCategories: {},
      errorMessages: {},
    );
  }

  MultiCategoryMovieState copyWith({
    Map<String, List<Movie>>? moviesByCategory,
    Set<String>? loadingCategories,
    Map<String, String>? errorMessages,
  }) {
    return MultiCategoryMovieState(
      moviesByCategory: moviesByCategory ?? this.moviesByCategory,
      loadingCategories: loadingCategories ?? this.loadingCategories,
      errorMessages: errorMessages ?? this.errorMessages,
    );
  }
}

class MovieBloc extends Cubit<MultiCategoryMovieState> {
  final GetMoviesUseCase getMoviesUseCase;

  MovieBloc(this.getMoviesUseCase) : super(MultiCategoryMovieState.initial());

  void fetchMovies(String category, {String? query}) async {
    emit(
      state.copyWith(
        loadingCategories: {...state.loadingCategories, category},
      ),
    );

    try {
      List<Movie> movies;

      // Выполняем поиск, если есть запрос, иначе загружаем фильмы по категории
      if (query != null && query.isNotEmpty) {
        movies = await getMoviesUseCase.execute(query: query);
      } else {
        movies = await getMoviesUseCase.execute(category: category);
      }

      emit(
        state.copyWith(
          moviesByCategory: {
            ...state.moviesByCategory,
            category: movies,
          },
          loadingCategories: state.loadingCategories..remove(category),
          errorMessages: {...state.errorMessages}..remove(category),
        ),
      );
    } on DioException catch (dioError) {
      emit(
        state.copyWith(
          loadingCategories: state.loadingCategories..remove(category),
          errorMessages: {
            ...state.errorMessages,
            category: 'Failed to load movies: ${dioError.message}',
          },
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingCategories: state.loadingCategories..remove(category),
          errorMessages: {
            ...state.errorMessages,
            category: 'An unexpected error occurred: $e',
          },
        ),
      );
    }
  }
}
