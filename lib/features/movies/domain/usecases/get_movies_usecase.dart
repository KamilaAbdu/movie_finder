import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMoviesUseCase {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<List<Movie>> execute({String category = 'popular'}) {
    return repository.getMovies(category);
  }
}
