import 'package:app_movie/features/movie/data/models/detail_movie.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<MovieDetailModel> call(int id) async {
    return await repository.getMovieDetail(id);
  }
}
