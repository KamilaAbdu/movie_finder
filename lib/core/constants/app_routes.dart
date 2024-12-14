import 'package:flutter/material.dart';
import 'package:movie_finder/features/movies/domain/entities/movie.dart';
import 'package:movie_finder/features/movies/presentation/pages/detail_page.dart';

class AppRoutes {
  static const home = '/';
  static const detail = '/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case detail:
        return MaterialPageRoute(builder: (_) => DetailPage(movie: settings.arguments as Movie,));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Нет указанного пути - ${settings.name}')),
          ),
        );
    }
  }
}

