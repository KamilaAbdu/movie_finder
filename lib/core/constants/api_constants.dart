class ApiConstants {
  static const apiKey = 'c270f872a687b068a2374f69edae257e';
  static const baseUrl = 'https://api.themoviedb.org/3';

  static String trendingMoviesUrl = '$baseUrl/movie/popular?language=en-US&api_key=$apiKey';
  static String topRatedMoviesUrl = '$baseUrl/movie/top_rated?language=en-US&api_key=$apiKey';
  static String upcomingMoviesUrl = '$baseUrl/movie/upcoming?language=en-US&api_key=$apiKey';
}
