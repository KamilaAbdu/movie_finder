import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMoviesUseCase {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<List<Movie>> execute({String category = 'popular', String query = ''}) {
    if (query.isNotEmpty) {
      return repository.searchMovies(query);
    } else {
      return repository.getMovies(category);
    }
  }
}

