import 'package:shared_preferences/shared_preferences.dart';

class CacheService{

  late SharedPreferences prefs;

  //Set string value for given title to cache
  void setStringValue(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  //Get string value for given key from cache
  Future<String> getStringValue(String key) async {
    final myPrefs = await SharedPreferences.getInstance();
    String lang = myPrefs.getString(key) ?? "null";
    return lang;
  }
}