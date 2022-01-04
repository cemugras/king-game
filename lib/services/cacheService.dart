import 'package:shared_preferences/shared_preferences.dart';

class CacheService{

  late SharedPreferences prefs;

  void cleanCache() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  //Set string value for given title to cache
  void setStringValue(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  //Set string list value for given title to cache
  void setStringList(String key, List<String> list) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, list);
  }

  //Set integer value for given title to cache
  void setIntValue(String key, int value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
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

  //Get string list value for given title from cache
  Future<List<String>> getStringList(String key) async {
    final myPrefs = await SharedPreferences.getInstance();
    List<String>? value = myPrefs.getStringList(key) ?? ["null"];
    return value;
  }

  //Get integer value for given key from cache
  Future<int> getIntValue(String key) async {
    final myPrefs = await SharedPreferences.getInstance();
    int value = myPrefs.getInt(key) ?? 1;
    return value;
  }

  //Get boolean value for given key from cache
  Future<bool> getBooleanValue(String key) async {
    final myPrefs = await SharedPreferences.getInstance();
    bool value = myPrefs.getBool(key) ?? false;
    return value;
  }


}
