import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  void saveInit(bool init) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('init', init);
  }

  Future<bool> getInit() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('init') ?? false;
  }
}
