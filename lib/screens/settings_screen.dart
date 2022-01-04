import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:king_game/services/contentService.dart';
import 'package:king_game/services/cacheService.dart';

import 'languages_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _nightMode = false;
  String pageName = "settings";
  late String _language;
  String _appBarTitle = "",
      _languageTitle = "", _languageSubtitle = "",
      _nightModeTitle = "",
      _resetDataTitle = "", _resetDataSubtitle = "",
      _envTitle = "", _envSubTitle = "",
      _devLicenceTitle = "",
      _settingsSectionCommon = "", _settingsSectionMisc = "",
      _versionTitle = "", _versionNumber = "";
  Color _appBarBackground = Colors.red, _bodyBackground = Colors.white, _heading = Colors.blue, _text = Colors.black;
  static const IconData trashIcon = IconData(0xe535, fontFamily: 'MaterialIcons');


  @override
  void initState() {
    super.initState();
    _getLanguage();
    _getDarkTheme();
  }

  void _getLanguage() async {
    _language = await CacheService().getStringValue("language");
    setState(() {
      _appBarTitle = ContentService().getAppBarTitle(_language.toString(), pageName);
      _languageTitle = ContentService().getContent(_language.toString(), "langTitle");
      _languageSubtitle = ContentService().getContent(_language.toString(), "langSubTitle");
      _nightModeTitle = ContentService().getContent(_language.toString(), "nightModeTitle");
      _envTitle = ContentService().getContent(_language.toString(), "envTitle");
      _envSubTitle = ContentService().getContent(_language.toString(), "envSubTitle");
      _devLicenceTitle = ContentService().getContent(_language.toString(), "devLicenceTitle");
      _settingsSectionCommon = ContentService().getContent(_language.toString(), "settingsSectionCommon");
      _settingsSectionMisc = ContentService().getContent(_language.toString(), "settingsSectionMisc");
      _versionTitle = ContentService().getContent(_language.toString(), "versionTitle");
      _versionNumber = ContentService().getContent(_language.toString(), "versionNumber");
      _resetDataTitle = ContentService().getContent(_language.toString(), "resetDataTitle");
      _resetDataSubtitle = ContentService().getContent(_language.toString(), "resetDataSubtitle");
    });
  }

  void _getDarkTheme() async {
    final nightMode = await ContentService().getDarkTheme();
    setState(() {
      _nightMode = nightMode;
      _appBarBackground = ContentService().getContentColor("appBarBackground", _nightMode);
      _bodyBackground = ContentService().getContentColor("bodyBackground", _nightMode);
      _heading = ContentService().getContentColor("heading", _nightMode);
      _text = ContentService().getContentColor("text", _nightMode);
    });
  }

  void _setTheme(bool value) async {
    setState(() {
      ContentService().setTheme(value);
      _getDarkTheme();
    });
  }

  void _resetCache() async {
    setState(() {
      CacheService().cleanCache();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appBarBackground,
        centerTitle: true,
        title: Text(
          '$_appBarTitle',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      backgroundColor: _bodyBackground,
      sections: [
        SettingsSection(
          title: '$_settingsSectionCommon',
          titlePadding: EdgeInsets.only(left: 5.0, top: 5),
          titleTextStyle: TextStyle(color:_heading, fontWeight: FontWeight.bold),
          tiles: [
            SettingsTile(
              title: '$_languageTitle',
              titleTextStyle: TextStyle(color: _text, fontWeight: FontWeight.bold),
              subtitle: '$_languageSubtitle',
              subtitleTextStyle: TextStyle(color: _text),
              leading: Icon(Icons.language, color: _text),
              onPressed: (context) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagesScreen())).then((value) async {
                  _getLanguage();
                });
              },
            ),
            SettingsTile.switchTile(
              title: '$_nightModeTitle',
              titleTextStyle: TextStyle(color: _text, fontWeight: FontWeight.bold),
              leading: Icon(Icons.phonelink_lock, color: _text),
              switchValue: _nightMode,
              switchActiveColor: _heading,
              onToggle: (bool value) {
                setState(() {
                  _setTheme(value);
                });
              },
            ),
            SettingsTile(
              title: '$_resetDataTitle',
              titleTextStyle: TextStyle(color: _text, fontWeight: FontWeight.bold),
              subtitle: '$_resetDataSubtitle',
              subtitleTextStyle: TextStyle(color: _text),
              leading: Icon(trashIcon, color: _text),
              onPressed: (context) {
                _resetCache();
                _getDarkTheme();
                _getLanguage();
              },
            ),
            SettingsTile(
              title: '$_envTitle',
              titleTextStyle: TextStyle(color: _text, fontWeight: FontWeight.bold),
              subtitle: '$_envSubTitle',
              subtitleTextStyle: TextStyle(color: _text),
              leading: Icon(Icons.cloud_queue, color: _text),
            ),
          ],
        ),
        SettingsSection(
          title: '$_settingsSectionMisc',
          titlePadding: EdgeInsets.only(left: 5.0, top: 5),
          titleTextStyle: TextStyle(color: _heading, fontWeight: FontWeight.bold),
          tiles: [
            SettingsTile(
                title: '$_devLicenceTitle',
                titleTextStyle: TextStyle(color: _text, fontWeight: FontWeight.bold),
                leading: Icon(Icons.collections_bookmark, color: _text)),
          ],
        ),
        CustomSection(
          child: Column(
            children: [
              Text(
                '$_versionTitle : $_versionNumber',
                style: TextStyle(color: _text),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
