import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:king_game/models/constants.dart';
import 'package:king_game/services/cacheService.dart';

class ContentService{

  String getMenuTitleContent(String language, String contentName){
    switch (language) {
      case "TR":
        if(contentName == "newGameTitle")
          return AppBarConstants.CONTENT_NEWGAME_TITLE_TR;
        else if(contentName == "lastGameTitle")
          return AppBarConstants.CONTENT_LASTGAME_TITLE_TR;
        else if(contentName == "rulesTitle")
          return AppBarConstants.CONTENT_RULES_TITLE_TR;
        else if(contentName == "settingsTitle")
          return AppBarConstants.CONTENT_SETTINGS_TITLE_TR;
        else
          return "ErrorContent";
      case "EN":
        if(contentName == "newGameTitle")
          return AppBarConstants.CONTENT_NEWGAME_TITLE_EN;
        else if(contentName == "lastGameTitle")
          return AppBarConstants.CONTENT_LASTGAME_TITLE_EN;
        else if(contentName == "rulesTitle")
          return AppBarConstants.CONTENT_RULES_TITLE_EN;
        else if(contentName == "settingsTitle")
          return AppBarConstants.CONTENT_SETTINGS_TITLE_EN;
        else
          return "ErrorContent";
      case "null":
        return getMenuTitleContent("EN", contentName);
      default:
        return "ErrorContent";
    }
  }

  String getMenuSubtitleContent(String language, String contentName){
    switch (language) {
      case "TR":
        if(contentName == "newGameSubtitle")
          return AppBarConstants.CONTENT_NEWGAME_SUBTITLE_TR;
        else if(contentName == "lastGameSubtitle")
          return AppBarConstants.CONTENT_LASTGAME_SUBTITLE_TR;
        else if(contentName == "rulesSubtitle")
          return AppBarConstants.CONTENT_RULES_SUBTITLE_TR;
        else if(contentName == "settingsSubtitle")
          return AppBarConstants.CONTENT_SETTINGS_SUBTITLE_TR;
        else
          return "ErrorContent";
      case "EN":
        if(contentName == "newGameSubtitle")
          return AppBarConstants.CONTENT_NEWGAME_SUBTITLE_EN;
        else if(contentName == "lastGameSubtitle")
          return AppBarConstants.CONTENT_LASTGAME_SUBTITLE_EN;
        else if(contentName == "rulesSubtitle")
          return AppBarConstants.CONTENT_RULES_SUBTITLE_EN;
        else if(contentName == "settingsSubtitle")
          return AppBarConstants.CONTENT_SETTINGS_SUBTITLE_EN;
        else
          return "ErrorContent";
      case "null":
        return getMenuSubtitleContent("EN", contentName);
      default:
        return "ErrorContent";
    }
  }

  String getAppBarTitle(String language, String pageName){
    switch (language) {
      case "TR":
        if(pageName == "menu")
          return AppBarConstants.APPBAR_MENU_TR;
        else if(pageName == "rules")
          return AppBarConstants.APPBAR_RULES_TR;
        else if(pageName == "settings")
          return AppBarConstants.APPBAR_SETTINGS_TR;
        else if(pageName == "language")
          return AppBarConstants.APPBAR_LANG_TR;
        else
          return "ErrorPageName";
      case "EN":
        if(pageName == "menu")
          return AppBarConstants.APPBAR_MENU_EN;
        else if(pageName == "rules")
          return AppBarConstants.APPBAR_RULES_EN;
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
        else if(contentName == "versionNumber")
          return AppBarConstants.CONTENT_VERSION;
        else if(contentName == "noTricksTitle")
          return AppBarConstants.CONTENT_NOHAND_TR;
        else if(contentName == "noTricksDescr")
          return AppBarConstants.CONTENT_NOHAND_DESCR_TR;
        else if(contentName == "noHeartTitle")
          return AppBarConstants.CONTENT_NOHEART_TR;
        else if(contentName == "noHeartDescr")
          return AppBarConstants.CONTENT_NOHEART_DESCR_TR;
        else if(contentName == "noManTitle")
          return AppBarConstants.CONTENT_NOMAN_TR;
        else if(contentName == "noManDescr")
          return AppBarConstants.CONTENT_NOMAN_DESCR_TR;
        else if(contentName == "noQueenTitle")
          return AppBarConstants.CONTENT_NOQUEEN_TR;
        else if(contentName == "noQueenDescr")
          return AppBarConstants.CONTENT_NOQUEEN_DESCR_TR;
        else if(contentName == "noLast2Title")
          return AppBarConstants.CONTENT_NOLAST2_TR;
        else if(contentName == "noLast2Descr")
          return AppBarConstants.CONTENT_NOLAST2_DESCR_TR;
        else if(contentName == "noHeartKingTitle")
          return AppBarConstants.CONTENT_NOHEARTKING_TR;
        else if(contentName == "noHeartKingDescr")
          return AppBarConstants.CONTENT_NOHEARTKING_DESCR_TR;
        else if(contentName == "trumpTitle")
          return AppBarConstants.CONTENT_TRUMP_TR;
        else if(contentName == "trumpDescr")
          return AppBarConstants.CONTENT_TRUMP_DESCR_TR;
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
        else if(contentName == "versionNumber")
          return AppBarConstants.CONTENT_VERSION;
        else if(contentName == "noTricksTitle")
          return AppBarConstants.CONTENT_NOHAND_EN;
        else if(contentName == "noTricksDescr")
          return AppBarConstants.CONTENT_NOHAND_DESCR_EN;
        else if(contentName == "noHeartTitle")
          return AppBarConstants.CONTENT_NOHEART_EN;
        else if(contentName == "noHeartDescr")
          return AppBarConstants.CONTENT_NOHEART_DESCR_EN;
        else if(contentName == "noManTitle")
          return AppBarConstants.CONTENT_NOMAN_EN;
        else if(contentName == "noManDescr")
          return AppBarConstants.CONTENT_NOMAN_DESCR_EN;
        else if(contentName == "noQueenTitle")
          return AppBarConstants.CONTENT_NOQUEEN_EN;
        else if(contentName == "noQueenDescr")
          return AppBarConstants.CONTENT_NOQUEEN_DESCR_EN;
        else if(contentName == "noLast2Title")
          return AppBarConstants.CONTENT_NOLAST2_EN;
        else if(contentName == "noLast2Descr")
          return AppBarConstants.CONTENT_NOLAST2_DESCR_EN;
        else if(contentName == "noHeartKingTitle")
          return AppBarConstants.CONTENT_NOHEARTKING_EN;
        else if(contentName == "noHeartKingDescr")
          return AppBarConstants.CONTENT_NOHEARTKING_DESCR_EN;
        else if(contentName == "trumpTitle")
          return AppBarConstants.CONTENT_TRUMP_EN;
        else if(contentName == "trumpDescr")
          return AppBarConstants.CONTENT_TRUMP_DESCR_EN;
        else
          return "ErrorContent";
      case "null":
        return getContent("EN", contentName);
      default:
        return "ErrorContent";
    }
  }

  Future<bool> getDarkTheme() async {
    final theme = await CacheService().getBooleanValue("theme");
    return theme;
  }

  void setTheme(value) {
    CacheService().setBooleanValue("theme",value);
  }

  Color getContentColor(String value, bool darkTheme){
    switch (darkTheme){
      case false:
        if(value == "appBarBackground")
          return Colors.red;
        if(value == "bodyBackground")
          return Colors.white;
        if(value == "text")
          return Colors.black;
        if(value == "heading")
          return Colors.blue;
        if(value == "mainBodyBackground")
          return Colors.white;
        break;
      case true:
        if(value == "appBarBackground")
          return Colors.black54;
        if(value == "bodyBackground")
          return Colors.black45;
        if(value == "text")
          return Colors.white;
        if(value == "heading")
          return Colors.orangeAccent;
        if(value == "mainBodyBackground")
          return Colors.grey;
        break;
    }
    return Colors.white;

  }

}