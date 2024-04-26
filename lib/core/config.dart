import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late String baseUrl;
  static late String apiUser;
  static late String apiKey;

  static late String devBaseUrl;
  static late String devApiUser;
  static late String devApiKey;

  static void init() {
    baseUrl = dotenv.env['BASE_URL']!;
    apiUser = dotenv.env['API_USER']!;
    apiKey = dotenv.env['API_KEY']!;

    devBaseUrl = dotenv.env['DEV_BASE_URL']!;
    devApiKey = dotenv.env['DEV_API_KEY']!;
    devApiUser = dotenv.env['DEV_API_USER']!;

    print({
      "baseUrl": baseUrl,
      "apiUser": apiUser,
      "apiKey": apiKey,
      "devBaseUrl": devBaseUrl,
      "devApiKey": devApiKey,
      "devApiUser": devApiUser,
    });
  }
}
