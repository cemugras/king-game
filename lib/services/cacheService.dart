import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService{

  late SharedPreferences prefs;
  int language = 0;

  //Get int data for given title from cache
  void _loadLanguageData() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final lang = (prefs.getInt('language') ?? 0);
    language = lang;
  }

  //Set int data for given title to cache
  void _setLanguageData(int data) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt("language", data);
  }

  //Return language cache value, returns 0 if there is no cached value
  String getLanguage(){
    _loadLanguageData();
    if( language == 1){
      return "TR";
    }else if( language == 2){
      return "EN";
    }else
      return "ER";
  }

  //Return language cache value, returns 0 if there is no cached value
  setLanguage(String languagePref){
    if( languagePref == "EN"){
      _setLanguageData(2); //set english if existing language is not english
    }else if( languagePref == "TR"){
      _setLanguageData(1); //set turkish if existing language is not turkish
    }else
      return 0;
  }
}