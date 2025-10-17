import 'package:app_movie/features/movie/data/models/detail_movie.dart';
import 'package:app_movie/features/movie/data/models/video_model.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailModel movieDetail;
  final List<VideoModel> videos;
  MovieDetailLoaded({
    required this.movieDetail,
    required this.videos,
  });
}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError(this.message);
}
