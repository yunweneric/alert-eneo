import "package:intl/intl.dart";

class UtilHelper {
  static String formatDate(DateTime? date) {
    if (date == null) return "-- --";
    return DateFormat('dd MMMM, yyyy').format(date);
  }
}
