import 'package:hive/hive.dart';

import '../models/movie_model.dart';

class MovieLocalDataSource {
  Future<void> cacheMovies(String key, List<MovieModel> movies) async {
    final box = await Hive.openBox('movies');
    final jsonList = movies.map((m) => m.toJson()).toList();
    await box.put(key, jsonList);
  }

  Future<List<MovieModel>> getCachedMovies(String key) async {
    final box = await Hive.openBox('movies');
    final data = box.get(key);
    if (data == null) {
      return [];
    }
    final movies = (data as List)
        .map((e) => MovieModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return movies;
  }
}
