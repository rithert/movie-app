import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepository repository;

  MoviesCubit(this.repository) : super(MoviesInitial());

  Future<void> loadMovies() async {
    emit(MoviesLoading());
    try {
      final trending = await repository.getTrendingMovies();
      final upcoming = await repository.getUpcomingMovies();
      emit(MoviesLoaded(trending: trending, upcoming: upcoming));
    } catch (e) {
      emit(MoviesError('Error al cargar películas: $e'));
    }
  }
}
