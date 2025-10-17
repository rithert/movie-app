import 'package:app_movie/features/movie/data/models/detail_movie.dart';
import 'package:app_movie/features/movie/data/models/video_model.dart';
import 'package:app_movie/features/movie/domain/usecases/movie_detail.dart';
import 'package:app_movie/features/movie/domain/usecases/movie_video.dart';
import 'package:app_movie/features/movie/presentation/cubit/movies_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieVideos getMovieVideos;

  MovieDetailCubit({
    required this.getMovieDetail,
    required this.getMovieVideos,
  }) : super(MovieDetailInitial());

  Future<void> loadMovieDetail(int movieId) async {
    try {
      emit(MovieDetailLoading());
      final results = await Future.wait([
        getMovieDetail(movieId),
        getMovieVideos(movieId),
      ]);

      MovieDetailModel movieDetail = results[0] as MovieDetailModel;
      List<VideoModel> videos = results[1] as List<VideoModel>;

      emit(MovieDetailLoaded(
        movieDetail: movieDetail,
        videos: videos,
      ));
    } catch (e) {
      emit(MovieDetailError('Error al cargar el detalle: $e'));
    }
  }
}
