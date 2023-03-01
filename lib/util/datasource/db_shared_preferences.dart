import 'package:shared_preferences/shared_preferences.dart';

class DbSharedPreferences {
  //membuat method singleton
  static final DbSharedPreferences _dbHelper = DbSharedPreferences._singleton();

  factory DbSharedPreferences() {
    return _dbHelper;
  }

  DbSharedPreferences._singleton();

  final _prefs = SharedPreferences.getInstance();

  inputDataString(String data, String value) async {
    final SharedPreferences prefs = await _prefs;
    var result = prefs.setString(data, value);
    return result;
  }

  getDataString(String data) async {
    final SharedPreferences prefs = await _prefs;
    final String? output = prefs.getString(data);
    return output ?? "";
  }

  void deleteDataString(String data) {
    final SharedPreferences prefs = _prefs as SharedPreferences;
    prefs.remove(data);
  }

  saveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('key', "value");
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('key');
    return stringValue;
  }
}
