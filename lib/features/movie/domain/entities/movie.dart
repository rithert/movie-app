class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final String originalLanguage;

  // Campos opcionales para organización local (no vienen del API directamente)
  final bool isTrending;
  final bool isUpcoming;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.originalLanguage,
    this.isTrending = false,
    this.isUpcoming = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json,
      {bool trending = false, bool upcoming = false}) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      originalLanguage: json['original_language'] ?? '',
      isTrending: trending,
      isUpcoming: upcoming,
    );
  }

  String get posterUrl => 'https://image.tmdb.org/t/p/w500$posterPath';
}
