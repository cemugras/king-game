import 'package:shared_preferences/shared_preferences.dart';

class CacheService{

  late SharedPreferences prefs;

  //Set string value for given title to cache
  void setStringValue(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  //Set boolean value for given title to cache
  void setBooleanValue(String key, bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  //Get string value for given key from cache
  Future<String> getStringValue(String key) async {
    final myPrefs = await SharedPreferences.getInstance();
    String value = myPrefs.getString(key) ?? "null";
    return value;
  }

  //Get boolean value for given key from cache
  Future<bool> getBooleanValue(String key) async {
    final myPrefs = await SharedPreferences.getInstance();
    bool value = myPrefs.getBool(key) ?? false;
    return value;
  }
}