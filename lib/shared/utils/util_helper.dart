import "dart:convert";

import "package:intl/intl.dart";

class UtilHelper {
  static String formatDate(DateTime? date) {
    if (date == null) return "-- --";
    return DateFormat('dd MMMM, yyyy').format(date);
  }

  static String encodeCredentials(
      {required String apiUser, required String apiPassword}) {
    // Concatenate apiUser and apiPassword with a colon
    String credentials = '$apiUser:$apiPassword';

    // Convert the credentials string to a list of UTF-8 bytes
    List<int> bytes = utf8.encode(credentials);

    // Encode the bytes to Base64
    String base64Encoded = base64.encode(bytes);

    return base64Encoded;
  }
}
