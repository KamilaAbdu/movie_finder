import 'package:flutter/material.dart';
import 'package:movie_finder/core/constants/app_dimens.dart';
import '../../../domain/entities/movie.dart';

class MovieCarousel extends StatelessWidget {
  final List<Movie> movies;

  const MovieCarousel({required this.movies, Key? key}) : super(key: key);

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
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: movie,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppDimens.padding / 2),
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


