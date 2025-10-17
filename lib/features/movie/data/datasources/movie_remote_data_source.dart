import 'package:app_movie/core/config/env.config.dart';
import 'package:app_movie/core/constants/api_url.dart';
import 'package:app_movie/features/movie/data/models/detail_movie.dart';
import 'package:app_movie/features/movie/data/models/video_model.dart';
import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class MovieRemoteDataSource {
  final Dio client;

  MovieRemoteDataSource(this.client);

  Map<String, String> get _headers => {
        'Authorization': 'Bearer ${EnvConfig.apiKey}',
        'Content-Type': 'application/json',
      };

  Future<List<MovieModel>> getTrending() async {
    final res = await client.get(
      ApiUrls.trending,
      options: Options(headers: _headers),
    );
    final results = res.data['results'] as List;
    return results.map((e) => MovieModel.fromJson(e)).toList();
  }

  Future<List<MovieModel>> getUpcoming() async {
    final res = await client.get(
      ApiUrls.upcoming,
      options: Options(headers: _headers),
    );
    final results = res.data['results'] as List;
    return results.map((e) => MovieModel.fromJson(e)).toList();
  }

  Future<MovieDetailModel> getMovieDetail(int id) async {
    final res = await client.get(
      '${ApiUrls.movieDetail}/$id',
      options: Options(headers: _headers),
    );
    return MovieDetailModel.fromJson(res.data);
  }

  Future<List<VideoModel>> getMovieVideos(int movieId) async {
    final res = await client.get(
      '${ApiUrls.baseUrl}/movie/$movieId/videos',
      options: Options(headers: _headers),
    );
    final results = res.data['results'] as List;
    return results.map((e) => VideoModel.fromJson(e)).toList();
  }
}
