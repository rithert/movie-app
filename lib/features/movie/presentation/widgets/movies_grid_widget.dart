import 'package:app_movie/features/movie/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'movie_card.dart';

class MoviesGridWidget extends StatelessWidget {
  final List<Movie> movies;

  const MoviesGridWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movies.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 250,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return MovieCard(movie: movies[index]);
      },
    );
  }
}
