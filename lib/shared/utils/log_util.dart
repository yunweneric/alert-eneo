import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

logI(data) {
  if (kDebugMode) logger.i(data);
}

logError(data) {
  if (kDebugMode) logger.e(data);
}
