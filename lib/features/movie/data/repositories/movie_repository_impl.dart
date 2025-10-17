import 'package:app_movie/features/movie/data/models/detail_movie.dart';

import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';
import '../datasources/movie_local_data_source.dart';
import '../../../../core/network/network_info.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remote;
  final MovieLocalDataSource local;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<List<Movie>> getTrendingMovies() async {
    if (await networkInfo.isConnected) {
      final movies = await remote.getTrending();
      await local.cacheMovies('trending', movies);
      return movies;
    } else {
      return local.getCachedMovies('trending');
    }
  }

  @override
  Future<List<Movie>> getUpcomingMovies() async {
    if (await networkInfo.isConnected) {
      final movies = await remote.getUpcoming();
      await local.cacheMovies('upcoming', movies);
      return movies;
    } else {
      return local.getCachedMovies('upcoming');
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    if (await networkInfo.isConnected) {
      final movie = await remote.getMovieDetail(id);
      return movie;
    } else {
      throw Exception('No hay conexión a internet');
    }
  }
}
