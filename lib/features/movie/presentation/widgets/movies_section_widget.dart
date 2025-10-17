import 'package:app_movie/core/utils/navigation_service.dart';
import 'package:app_movie/features/movie/presentation/cubit/movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:app_movie/features/movie/domain/entities/movie.dart';
import 'package:app_movie/features/movie/presentation/pages/movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesSectionWidget extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSectionWidget({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                NavigationService.navigateTo(
                  BlocProvider.value(
                    value: context.read<MoviesCubit>(),
                    child: MovieDetailPage(movie: movie),
                  ),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(movie.posterUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
