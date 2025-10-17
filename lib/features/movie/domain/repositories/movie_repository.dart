import 'package:app_movie/features/movie/data/models/detail_movie.dart';
import 'package:app_movie/features/movie/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTrendingMovies();
  Future<List<Movie>> getUpcomingMovies();
  Future<MovieDetailModel> getMovieDetail(int id);
}
