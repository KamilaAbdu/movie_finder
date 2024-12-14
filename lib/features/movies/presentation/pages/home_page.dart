import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/constants/app_text_styles.dart';
import 'package:movie_finder/features/movies/presentation/pages/widgets/search_bar.dart';
import '../bloc/movie_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_finder/features/movies/domain/entities/movie.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);

    // Инициализация категорий фильмов
    movieBloc.fetchMovies('popular');
    movieBloc.fetchMovies('top_rated');
    movieBloc.fetchMovies('upcoming');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Movie Finder',
          style: AppTextStyles.title.copyWith(color: Colors.red),
        ),
        actions: [SearchWidget(
          onSearch: (query) {
            if (query.isNotEmpty) {
              movieBloc.fetchMovies('search', query: query); // Добавлен запрос поиска
            } else {
              movieBloc.fetchMovies('popular'); // Сброс на популярные фильмы
            }
          },
        ),]
      ),
      body: BlocBuilder<MovieBloc, MultiCategoryMovieState>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.moviesByCategory['search'] != null &&
                      state.moviesByCategory['search']!.isNotEmpty)
                    _buildCategory(context, 'search', 'Search Results'),
                  const SizedBox(height: 32),
                  _buildCategory(context, 'popular', 'Trending Movies'),
                  const SizedBox(height: 32),
                  _buildCategory(context, 'top_rated', 'Top Rated Movies'),
                  const SizedBox(height: 32),
                  _buildCategory(context, 'upcoming', 'Upcoming Movies'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String category, String title) {
    return BlocBuilder<MovieBloc, MultiCategoryMovieState>(
      builder: (context, state) {
        final isLoading = state.loadingCategories.contains(category);
        final errorMessage = state.errorMessages[category];
        final movies = state.moviesByCategory[category];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.aBeeZee(fontSize: 25),
            ),
            const SizedBox(height: 16),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (errorMessage != null)
              Center(
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else if (movies != null)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Image.network(
                            movie.posterPath,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            else
              const Center(child: Text('No movies available')),
          ],
        );
      },
    );
  }
}
