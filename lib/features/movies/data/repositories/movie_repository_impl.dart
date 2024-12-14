import 'package:dio/dio.dart';
import 'package:movie_finder/core/constants/api_constants.dart';
import 'package:movie_finder/features/movies/data/models/movie_model.dart';
import 'package:movie_finder/features/movies/domain/entities/movie.dart';
import 'package:movie_finder/features/movies/domain/repositories/movie_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio dio;

  MovieRepositoryImpl(this.dio);

  @override
  Future<List<Movie>> getMovies(String category) async {
    final url =
        '${ApiConstants.baseUrl}/movie/$category?language=en-US&api_key=${ApiConstants.apiKey}';

    // Проверка соединения
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No Internet connection');
    }

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final List results = response.data['results'];
        return results.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Логирование ошибок
      print('DioError: ${e.response?.data}');
      throw Exception('Failed to fetch movies: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
