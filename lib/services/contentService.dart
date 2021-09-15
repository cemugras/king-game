import 'package:king_game/models/menu_model.dart';
import 'package:king_game/models/constants.dart';
import 'package:king_game/services/cacheService.dart';

class ContentService{

  String getMenuTitle(String language, int index){
    if(language == 'TR'){
      return turkish[index].title;
    }else if(language == 'EN'){
      return english[index].title;
    }else
      return options[index - 1].title;
  }

  String getMenuSubtitle(String language, int index){
    if(language == 'TR'){
      return turkish[index].subtitle;
    }else if(language == 'EN'){
      return english[index].subtitle;
    }else
      return options[index - 1].subtitle;
  }

  String getAppBarTitle(String language, String pageName){

    switch (language) {
      case "TR":
        if(pageName == "menu")
          return AppBarConstants.APPBAR_MENU_TR;
        else if(pageName == "settings")
          return AppBarConstants.APPBAR_SETTINGS_TR;
        else if(pageName == "language")
          return AppBarConstants.APPBAR_LANG_TR;
        else
          return "ErrorPageName";
      case "EN":
        if(pageName == "menu")
          return AppBarConstants.APPBAR_MENU_EN;
        else if(pageName == "settings")
          return AppBarConstants.APPBAR_SETTINGS_EN;
        else if(pageName == "language")
          return AppBarConstants.APPBAR_LANG_EN;
        else
          return "ErrorPageName";
      case "null":
        return getAppBarTitle("EN", pageName);
      default:
        return "ErrorPageName";
    }
    /*if(language == "TR" && pageName == "menu"){
      return AppBarConstants.APPBAR_MENU_TR;
    }else if(language == "EN" && pageName == "menu"){
      return AppBarConstants.APPBAR_MENU_EN;
    }else if(language == "TR" && pageName == "settings"){
      return AppBarConstants.APPBAR_SETTINGS_TR;
    }else if(language == "EN" && pageName == "settings"){
      return AppBarConstants.APPBAR_SETTINGS_EN;
    }else if(language == "TR" && pageName == "language"){
      return AppBarConstants.APPBAR_LANG_TR;
    }else if(language == "EN" && pageName == "language"){
      return AppBarConstants.APPBAR_LANG_EN;
    }else if(language == "null")
      return "ErrorPageName";*/
  }

  String getLanguage() {
    return CacheService().getStringValue("language") as String;
  }
}