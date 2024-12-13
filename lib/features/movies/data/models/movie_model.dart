import 'package:movie_finder/features/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
    required super.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: 'https://image.tmdb.org/t/p/w500${json['poster_path'] ?? ''}',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

