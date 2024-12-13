import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/features/movies/domain/entities/movie.dart';
import 'package:movie_finder/features/movies/domain/usecases/get_movies_usecase.dart';

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

class MovieState {
}

class MovieBloc extends Cubit<MultiCategoryMovieState> {
  final GetMoviesUseCase getMoviesUseCase;

  MovieBloc(this.getMoviesUseCase) : super(MultiCategoryMovieState.initial());

  void fetchMovies(String category) async {
    emit(state.copyWith(loadingCategories: {...state.loadingCategories, category}));
    try {
      final movies = await getMoviesUseCase.execute(category: category);
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
    } catch (e) {
      emit(
        state.copyWith(
          loadingCategories: state.loadingCategories..remove(category),
          errorMessages: {
            ...state.errorMessages,
            category: e.toString(),
          },
        ),
      );
    }
  }
}

