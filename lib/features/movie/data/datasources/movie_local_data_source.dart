import 'package:hive/hive.dart';

import '../models/movie_model.dart';

class MovieLocalDataSource {
  Future<void> cacheMovies(String key, List<MovieModel> movies) async {
    final box = await Hive.openBox('movies');
    final jsonList = movies.map((m) => m.toJson()).toList();
    await box.put(key, jsonList);
    print('💾 Cached ${movies.length} movies with key: $key'); // Log temporal
  }

  Future<List<MovieModel>> getCachedMovies(String key) async {
    final box = await Hive.openBox('movies');
    final data = box.get(key);
    if (data == null) {
      print('❌ No cached movies found for key: $key'); // Log temporal
      return [];
    }
    final movies = (data as List)
        .map((e) => MovieModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    print(
        '✅ Loaded ${movies.length} cached movies for key: $key'); // Log temporal
    return movies;
  }
}
