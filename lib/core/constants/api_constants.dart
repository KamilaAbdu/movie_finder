class ApiConstants {
  static const apiKey = 'c270f872a687b068a2374f69edae257e';
  static const baseUrl = 'https://api.themoviedb.org/3';

  static String trendingMoviesUrl = '$baseUrl/trending/movie/day?api_key=$apiKey';
  static String topRatedMoviesUrl = '$baseUrl/movie/top_rated?api_key=$apiKey';
  static String upcomingMoviesUrl = '$baseUrl/movie/upcoming?api_key=$apiKey';
}
