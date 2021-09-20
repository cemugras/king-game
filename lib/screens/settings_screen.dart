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
  String _language = "null";
  String _appBarTitle = "null",
      _languageTitle = "null", _languageSubtitle = "null",
      _nightModeTitle = "null",
      _envTitle = "null", _envSubTitle = "null",
      _devLicenceTitle = "null",
      _settingsSectionCommon = "null", _settingsSectionMisc = "null",
      _versionTitle = "null", _versionNumber = "null";


  @override
  void initState() {
    super.initState();
    _getLanguage();
    _getDarkTheme();
  }

  void _getLanguage() async {
    _language = await CacheService().getStringValue("language");
    final appBarTitle = ContentService().getAppBarTitle(_language.toString(), pageName);
    final languageTitle = ContentService().getContent(_language.toString(), "langTitle");
    final languageSubTitle = ContentService().getContent(_language.toString(), "langSubTitle");
    final nightModeTitle = ContentService().getContent(_language.toString(), "nightModeTitle");
    final envTitle = ContentService().getContent(_language.toString(), "envTitle");
    final envSubTitle = ContentService().getContent(_language.toString(), "envSubTitle");
    final devLicenceTitle = ContentService().getContent(_language.toString(), "devLicenceTitle");
    final settingsSectionCommon = ContentService().getContent(_language.toString(), "settingsSectionCommon");
    final settingsSectionMisc = ContentService().getContent(_language.toString(), "settingsSectionMisc");
    final versionTitle = ContentService().getContent(_language.toString(), "versionTitle");
    final versionNumber = ContentService().getContent(_language.toString(), "versionNumber");
    setState(() {
      _appBarTitle = appBarTitle;
      _languageTitle = languageTitle;
      _languageSubtitle = languageSubTitle;
      _nightModeTitle = nightModeTitle;
      _envTitle = envTitle;
      _envSubTitle = envSubTitle;
      _devLicenceTitle = devLicenceTitle;
      _settingsSectionCommon = settingsSectionCommon;
      _settingsSectionMisc = settingsSectionMisc;
      _versionTitle = versionTitle;
      _versionNumber = versionNumber;
    });
  }

  void _getDarkTheme() async {
    final nightMode = await ContentService().getDarkTheme();
    setState(() {
      _nightMode = nightMode;
    });
  }

  void _setTheme(bool value) async {
    setState(() {
      ContentService().setTheme(value);
      _getDarkTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ContentService().getContentColor("appBarBackground", _nightMode),
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
      backgroundColor: ContentService().getContentColor("bodyBackground", _nightMode),
      sections: [
        SettingsSection(
          title: '$_settingsSectionCommon',
          titleTextStyle: TextStyle(color:ContentService().getContentColor("heading", _nightMode), fontWeight: FontWeight.bold),
          tiles: [
            SettingsTile(
              title: '$_languageTitle',
              titleTextStyle: TextStyle(color:ContentService().getContentColor("text", _nightMode), fontWeight: FontWeight.bold),
              subtitle: '$_languageSubtitle',
              subtitleTextStyle: TextStyle(color:ContentService().getContentColor("text", _nightMode)),
              leading: Icon(Icons.language, color: ContentService().getContentColor("text", _nightMode)),
              onPressed: (context) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagesScreen())).then((value) async {
                  _getLanguage();
                });
              },
            ),
            SettingsTile.switchTile(
              title: '$_nightModeTitle',
              titleTextStyle: TextStyle(color:ContentService().getContentColor("text", _nightMode), fontWeight: FontWeight.bold),
              leading: Icon(Icons.phonelink_lock, color: ContentService().getContentColor("text", _nightMode)),
              switchValue: _nightMode,
              switchActiveColor: ContentService().getContentColor("heading", _nightMode),
              onToggle: (bool value) {
                setState(() {
                  _setTheme(value);
                });
              },
            ),
            SettingsTile(
              title: '$_envTitle',
              titleTextStyle: TextStyle(color:ContentService().getContentColor("text", _nightMode), fontWeight: FontWeight.bold),
              subtitle: '$_envSubTitle',
              subtitleTextStyle: TextStyle(color:ContentService().getContentColor("text", _nightMode)),
              leading: Icon(Icons.cloud_queue, color: ContentService().getContentColor("text", _nightMode)),
            ),
          ],
        ),
        SettingsSection(
          title: '$_settingsSectionMisc',
          titleTextStyle: TextStyle(color:ContentService().getContentColor("heading", _nightMode), fontWeight: FontWeight.bold),
          tiles: [
            SettingsTile(
                title: '$_devLicenceTitle',
                titleTextStyle: TextStyle(color:ContentService().getContentColor("text", _nightMode), fontWeight: FontWeight.bold),
                leading: Icon(Icons.collections_bookmark, color: ContentService().getContentColor("text", _nightMode))),
          ],
        ),
        CustomSection(
          child: Column(
            children: [
              Text(
                '$_versionTitle : $_versionNumber',
                style: TextStyle(color:ContentService().getContentColor("text", _nightMode)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
