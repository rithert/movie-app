import 'package:app_movie/features/movie/domain/entities/movie.dart';
import 'package:app_movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepository repository;

  MoviesCubit(this.repository) : super(MoviesInitial());

  Future<void> loadMovies() async {
    try {
      emit(MoviesLoading());

      final upcoming = await repository.getUpcomingMovies();
      final trending = await repository.getTrendingMovies();

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
