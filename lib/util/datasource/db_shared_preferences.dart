import 'package:shared_preferences/shared_preferences.dart';

class DbSharedPreferences {
  //membuat method singleton
  static final DbSharedPreferences _dbHelper = DbSharedPreferences._singleton();

  factory DbSharedPreferences() {
    return _dbHelper;
  }

  DbSharedPreferences._singleton();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> inputDataString(String data, String value) async {
    final SharedPreferences prefs = await _prefs;
    var result = prefs.setString(data, value);
    return result;
  }

  String? getDataString(String data) {
    final SharedPreferences prefs = _prefs as SharedPreferences;
    final String? output = prefs.getString(data);
    return output;
  }

  void deleteDataString(String data) {
    final SharedPreferences prefs = _prefs as SharedPreferences;
    prefs.remove(data);
  }
}
