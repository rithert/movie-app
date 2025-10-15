// movies_state.dart
part of 'movies_cubit.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> trending;
  final List<Movie> upcoming;
  MoviesLoaded({required this.trending, required this.upcoming});
}

class MoviesError extends MoviesState {
  final String message;
  MoviesError(this.message);
}
