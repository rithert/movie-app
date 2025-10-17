class VideoResponse {
  final int id;
  final List<VideoModel> results;

  const VideoResponse({
    required this.id,
    required this.results,
  });

  factory VideoResponse.fromJson(Map<String, dynamic> json) {
    return VideoResponse(
      id: json['id'] ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((video) => VideoModel.fromJson(video))
              .toList() ??
          [],
    );
  }
}

class VideoModel {
  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  const VideoModel({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      iso6391: json['iso_639_1'] ?? '',
      iso31661: json['iso_3166_1'] ?? '',
      name: json['name'] ?? '',
      key: json['key'] ?? '',
      site: json['site'] ?? '',
      size: json['size'] ?? 0,
      type: json['type'] ?? '',
      official: json['official'] ?? false,
      publishedAt: json['published_at'] ?? '',
      id: json['id'] ?? '',
    );
  }

  String get youtubeUrl => 'https://www.youtube.com/watch?v=$key';

  bool get isYouTubeTrailer =>
      site.toLowerCase() == 'youtube' && type.toLowerCase() == 'trailer';
}
