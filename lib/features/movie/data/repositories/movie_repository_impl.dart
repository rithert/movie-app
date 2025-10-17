import 'package:app_movie/features/movie/data/models/detail_movie.dart';
import 'package:app_movie/features/movie/data/models/video_model.dart';

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
    try {
      if (await networkInfo.isConnected) {
        final movies = await remote.getTrending();
        await local.cacheMovies('trending', movies);
        return movies;
      } else {
        return await local.getCachedMovies('trending');
      }
    } catch (e) {
      // Si hay error de red, intentar usar caché
      final cachedMovies = await local.getCachedMovies('trending');
      if (cachedMovies.isNotEmpty) {
        return cachedMovies;
      }
      rethrow; // Si no hay caché, lanzar el error original
    }
  }

  @override
  Future<List<Movie>> getUpcomingMovies() async {
    try {
      if (await networkInfo.isConnected) {
        final movies = await remote.getUpcoming();
        await local.cacheMovies('upcoming', movies);
        return movies;
      } else {
        return await local.getCachedMovies('upcoming');
      }
    } catch (e) {
      final cachedMovies = await local.getCachedMovies('upcoming');
      if (cachedMovies.isNotEmpty) {
        return cachedMovies;
      }
      rethrow;
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final movie = await remote.getMovieDetail(id);
        return movie;
      } catch (e) {
        throw Exception('Error al cargar detalles de la película');
      }
    } else {
      throw Exception('No hay conexión a internet');
    }
  }

  @override
  Future<List<VideoModel>> getMovieVideos(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final videos = await remote.getMovieVideos(movieId);
        return videos;
      } catch (e) {
        throw Exception('Error al cargar videos de la película');
      }
    } else {
      throw Exception('No hay conexión a internet');
    }
  }
}
