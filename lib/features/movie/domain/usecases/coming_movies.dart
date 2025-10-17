import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetUpcomingMovies {
  final MovieRepository repository;

  GetUpcomingMovies(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getUpcomingMovies();
  }
}
