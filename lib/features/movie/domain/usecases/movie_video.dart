import 'package:app_movie/features/movie/data/models/video_model.dart';
import 'package:app_movie/features/movie/domain/repositories/movie_repository.dart';

class GetMovieVideos {
  final MovieRepository repository;

  GetMovieVideos(this.repository);

  Future<List<VideoModel>> call(int movieId) async {
    return await repository.getMovieVideos(movieId);
  }
}
