import 'package:app_movie/core/utils/navigation_service.dart';
import 'package:app_movie/features/movie/presentation/cubit/movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:app_movie/features/movie/domain/entities/movie.dart';
import 'package:app_movie/features/movie/presentation/pages/movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MoviesGridWidget extends StatelessWidget {
  final List<Movie> movies;

  const MoviesGridWidget({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: () {
            NavigationService.navigateTo(
              BlocProvider.value(
                value: context.read<MoviesCubit>(),
                child: MovieDetailPage(movie: movie),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: movie.posterUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[800],
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[800],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.movie,
                      size: 32,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sin imagen',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
