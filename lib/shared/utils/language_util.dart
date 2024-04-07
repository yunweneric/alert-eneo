import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LangUtil {
  static String trans(String? key, {Map<String, String>? args}) {
    if (key != '' && key != null) {
      String val = tr(key, namedArgs: args);
      return val;
    } else
      return '';
  }

  static bool isFrench(BuildContext context) {
    return context.locale.languageCode.contains('fr');
  }

  static String local(BuildContext context) {
    return context.locale.languageCode.contains('fr') ? "fr" : "en";
  }
}
