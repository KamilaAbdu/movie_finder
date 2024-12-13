import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/features/movies/domain/entities/movie.dart';
import 'package:movie_finder/features/movies/presentation/pages/detail_page.dart';
import 'package:movie_finder/features/movies/presentation/pages/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: DetailRoute.page),
      ];
}