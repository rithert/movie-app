import 'package:app_movie/core/config/env.config.dart';
import 'package:app_movie/core/constants/api_url.dart';
import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class MovieRemoteDataSource {
  final Dio client;

  MovieRemoteDataSource(this.client);

  Future<List<MovieModel>> getTrending() async {
    final res = await client.get(
      ApiUrls.trending,
      queryParameters: {'api_key': EnvConfig.apiKey},
    );
    final results = res.data['results'] as List;
    return results.map((e) => MovieModel.fromJson(e)).toList();
  }

  Future<List<MovieModel>> getUpcoming() async {
    final res = await client.get(
      ApiUrls.upcoming,
      queryParameters: {'api_key': EnvConfig.apiKey},
    );
    final results = res.data['results'] as List;
    return results.map((e) => MovieModel.fromJson(e)).toList();
  }

  Future<MovieModel> getMovieDetail(int id) async {
    final res = await client.get(
      '${ApiUrls.movieDetail}/$id',
      queryParameters: {'api_key': EnvConfig.apiKey},
    );
    return MovieModel.fromJson(res.data);
  }
}
