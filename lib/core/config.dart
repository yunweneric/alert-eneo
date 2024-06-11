import 'package:fapshi_pay/fapshi_pay.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late AppEnv env;
  static late String paymentBaseUrl;
  static late String eneoOutageBaseUrl;
  static late String apiUser;
  static late String apiKey;
  static late String apiPassword;

  static void init() {
    env = dotenv.env['ENV'] == "prod" ? AppEnv.prod : AppEnv.dev;
    paymentBaseUrl = dotenv.env['PAYMENT_BASE_URL']!;
    eneoOutageBaseUrl = dotenv.env['ENEO_ALERT_BASE_URL']!;
    apiPassword = dotenv.env['API_PASSWORD']!;
    apiUser = dotenv.env['API_USER']!;
    apiKey = dotenv.env['API_KEY']!;

    print({
      "env": env,
      "paymentBaseUrl": paymentBaseUrl,
      "eneoOutageBaseUrl": eneoOutageBaseUrl,
      "apiPassword": apiPassword,
      "apiUser": apiUser,
      "apiKey": apiKey,
    });
  }
}
