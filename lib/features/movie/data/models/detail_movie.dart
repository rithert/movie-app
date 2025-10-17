import 'package:app_movie/features/movie/domain/entities/movie.dart';

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }
}

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'],
      iso6391: json['iso_639_1'],
      name: json['name'],
    );
  }
}

class MovieDetailModel extends Movie {
  final bool adult;
  final String? backdropPath;
  final int? budget;
  final List<Genre> genres;
  final String? homepage;
  final String? imdbId;
  final double popularity;
  final List<ProductionCompany> productionCompanies;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final int voteCount;

  MovieDetailModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
    required super.voteAverage,
    required super.originalLanguage,
    super.isUpcoming = false,
    super.isTrending = false,
    required this.adult,
    this.backdropPath,
    this.budget,
    required this.genres,
    this.homepage,
    this.imdbId,
    required this.popularity,
    required this.productionCompanies,
    this.revenue,
    this.runtime,
    required this.spokenLanguages,
    required this.status,
    this.tagline,
    required this.voteCount,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      originalLanguage: json['original_language'],
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'],
      genres:
          (json['genres'] as List?)?.map((e) => Genre.fromJson(e)).toList() ??
              [],
      homepage: json['homepage'],
      imdbId: json['imdb_id'],
      popularity: json['popularity']?.toDouble() ?? 0.0,
      productionCompanies: (json['production_companies'] as List?)
              ?.map((e) => ProductionCompany.fromJson(e))
              .toList() ??
          [],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: (json['spoken_languages'] as List?)
              ?.map((e) => SpokenLanguage.fromJson(e))
              .toList() ??
          [],
      status: json['status'],
      tagline: json['tagline'],
      voteCount: json['vote_count'] ?? 0,
    );
  }

  // Getters útiles para la UI
  String get genresString => genres.map((g) => g.name).join(' • ');

  String get runtimeFormatted {
    if (runtime == null) return '--';
    final hours = runtime! ~/ 60;
    final minutes = runtime! % 60;
    return '${hours}h ${minutes}m';
  }

  String get primaryLanguage {
    if (spokenLanguages.isEmpty) return originalLanguage;
    return spokenLanguages.first.name;
  }

  String get releaseYear {
    if (releaseDate.isEmpty) return '--';
    return releaseDate.split('-').first;
  }
}
