import 'package:king_game/models/menu_model.dart';
import 'package:king_game/models/constants.dart';

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
  }

  String getContent(String language, String contentName){

    switch (language) {
      case "TR":
        if(contentName == "langTitle")
          return AppBarConstants.CONTENT_LANG_TITLE_TR;
        else if(contentName == "langSubTitle")
          return AppBarConstants.CONTENT_LANG_SUBTITLE_TR;
        else if(contentName == "nightModeTitle")
          return AppBarConstants.CONTENT_NIGHT_TITLE_TR;
        else if(contentName == "envTitle")
          return AppBarConstants.CONTENT_ENV_TITLE_TR;
        else if(contentName == "envSubTitle")
          return AppBarConstants.CONTENT_ENV_SUBTITLE_TR;
        else if(contentName == "devLicenceTitle")
          return AppBarConstants.CONTENT_DEV_LICENCE_TITLE_TR;
        else if(contentName == "settingsSectionCommon")
          return AppBarConstants.CONTENT_SETTINGS_SECTION_COMMON_TR;
        else if(contentName == "settingsSectionMisc")
          return AppBarConstants.CONTENT_SETTINGS_SECTION_MISC_TR;
        else if(contentName == "versionTitle")
          return AppBarConstants.CONTENT_VERSION_TR;
        else
          return "ErrorContent";
      case "EN":
        if(contentName == "langTitle")
          return AppBarConstants.CONTENT_LANG_TITLE_EN;
        else if(contentName == "langSubTitle")
          return AppBarConstants.CONTENT_LANG_SUBTITLE_EN;
        else if(contentName == "nightModeTitle")
          return AppBarConstants.CONTENT_NIGHT_TITLE_EN;
        else if(contentName == "envTitle")
          return AppBarConstants.CONTENT_ENV_TITLE_EN;
        else if(contentName == "envSubTitle")
          return AppBarConstants.CONTENT_ENV_SUBTITLE_EN;
        else if(contentName == "devLicenceTitle")
          return AppBarConstants.CONTENT_DEV_LICENCE_TITLE_EN;
        else if(contentName == "settingsSectionCommon")
          return AppBarConstants.CONTENT_SETTINGS_SECTION_COMMON_EN;
        else if(contentName == "settingsSectionMisc")
          return AppBarConstants.CONTENT_SETTINGS_SECTION_MISC_EN;
        else if(contentName == "versionTitle")
          return AppBarConstants.CONTENT_VERSION_EN;
        else
          return "ErrorContent";
      case "null":
        return getAppBarTitle("EN", contentName);
      default:
        return "ErrorContent";
    }
  }

}