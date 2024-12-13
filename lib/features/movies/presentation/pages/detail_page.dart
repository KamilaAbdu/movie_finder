import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/features/movies/domain/entities/movie.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

@RoutePage()
class DetailPage extends StatelessWidget {
  final Movie movie;

  const DetailPage({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              background: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Overview', style: AppTextStyles.header),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview,
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoTile(
                        title: 'Release Date',
                        value: movie.releaseDate,
                      ),
                      InfoTile(
                        title: 'Rating',
                        value: '${movie.voteAverage}/10',
                        icon: const Icon(Icons.star, color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final Widget? icon;

  const InfoTile(
      {required this.title, required this.value, this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (icon != null) icon!,
          Text(
            '$title: ',
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
