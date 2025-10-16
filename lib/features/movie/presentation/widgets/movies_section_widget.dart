import 'package:app_movie/features/movie/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'movie_card.dart';

class MoviesSectionWidget extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSectionWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return MovieCard(movie: movies[index]);
        },
      ),
    );
  }
}
