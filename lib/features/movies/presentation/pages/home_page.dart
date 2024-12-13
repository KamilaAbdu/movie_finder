import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);

    // Fetch movies for multiple categories
    movieBloc.fetchMovies('popular');
    movieBloc.fetchMovies('top_rated');
    movieBloc.fetchMovies('upcoming');

    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCategory(context, 'popular', 'Trending Movies'),
            _buildCategory(context, 'top_rated', 'Top Rated Movies'),
            _buildCategory(context, 'upcoming', 'Upcoming Movies'),
          ],
        ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (errorMessage != null)
              Center(child: Text(errorMessage))
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
