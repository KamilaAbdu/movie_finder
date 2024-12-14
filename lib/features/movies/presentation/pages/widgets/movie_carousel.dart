import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/core/constants/app_dimens.dart';
import 'package:movie_finder/core/router/app_router.dart';
import 'package:movie_finder/features/movies/presentation/pages/detail_page.dart';
import '../../../domain/entities/movie.dart';

class MovieCarousel extends StatelessWidget {
  final List<Movie> movies;

  const MovieCarousel({required this.movies, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              context.router.push(
                DetailRoute(movie: movie),
              );
            },
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: AppDimens.padding / 2),
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.cornerRadius),
                image: DecorationImage(
                  image: NetworkImage(movie.posterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
