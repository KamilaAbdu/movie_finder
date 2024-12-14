import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies(String category);
  Future<List<Movie>> searchMovies(String query);
}
