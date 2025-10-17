import 'package:app_movie/features/movie/data/models/detail_movie.dart';
import 'package:app_movie/features/movie/domain/entities/movie.dart';
import 'package:app_movie/features/movie/domain/usecases/coming_movies.dart';
import 'package:app_movie/features/movie/domain/usecases/movie_detail.dart';
import 'package:app_movie/features/movie/domain/usecases/trend_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetTrendingMovies getTrendingMovies;
  final GetUpcomingMovies getUpcomingMovies;

  MoviesCubit({
    required this.getTrendingMovies,
    required this.getUpcomingMovies,
  }) : super(MoviesInitial());

  Future<void> loadMovies() async {
    try {
      emit(MoviesLoading());

      final upcoming = await getUpcomingMovies();
      final trending = await getTrendingMovies();

      // Fusionamos ambas listas y marcamos origen
      final movies = [
        ...upcoming.map((m) => Movie(
              id: m.id,
              title: m.title,
              overview: m.overview,
              posterPath: m.posterPath,
              releaseDate: m.releaseDate,
              voteAverage: m.voteAverage,
              originalLanguage: m.originalLanguage,
              isUpcoming: true,
            )),
        ...trending.map((m) => Movie(
              id: m.id,
              title: m.title,
              overview: m.overview,
              posterPath: m.posterPath,
              releaseDate: m.releaseDate,
              voteAverage: m.voteAverage,
              originalLanguage: m.originalLanguage,
              isTrending: true,
            )),
      ];

      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MoviesError('Error al cargar películas: $e'));
    }
  }
}
