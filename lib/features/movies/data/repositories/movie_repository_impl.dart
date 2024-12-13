import 'package:dio/dio.dart';
import 'package:movie_finder/core/constants/api_constants.dart';
import 'package:movie_finder/features/movies/data/models/movie_model.dart';
import 'package:movie_finder/features/movies/domain/entities/movie.dart';
import 'package:movie_finder/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio dio;

  MovieRepositoryImpl(this.dio);

  @override
  Future<List<Movie>> getMovies(String category) async {
    final url = '${ApiConstants.baseUrl}/movie/$category?api_key=${ApiConstants.apiKey}';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final List results = response.data['results'];
        return results.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch movies: $e');
    }
  }
}

