import 'package:eneo_fails/core/bootstrap.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".dev.env");
  bootstrap();
}
