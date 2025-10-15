import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? 'TU_API_KEY_AQUI';

  static bool get isProduction =>
      dotenv.env['PRODUCTION']?.toLowerCase() == 'true';

  static Future<void> init() async {
    await dotenv.load(fileName: ".env");
  }
}
