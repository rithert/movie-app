import 'package:app_movie/features/movie/domain/usecases/movie_detail.dart';
import 'package:app_movie/features/movie/presentation/cubit/movies_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailCubit({
    required this.getMovieDetail,
  }) : super(MovieDetailInitial());

  Future<void> loadMovieDetail(int movieId) async {
    try {
      emit(MovieDetailLoading());
      final movieDetail = await getMovieDetail(movieId);
      emit(MovieDetailLoaded(movieDetail));
    } catch (e) {
      emit(MovieDetailError('Error al cargar el detalle: $e'));
    }
  }
}
