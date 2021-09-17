import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:king_game/services/contentService.dart';
import 'package:king_game/services/cacheService.dart';

import 'languages_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();

  void languageChanges() async {
    _SettingsScreenState()._getLanguage();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool nightMode = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.red,
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
      sections: [
        SettingsSection(
          title: '$_settingsSectionCommon',
          tiles: [
            SettingsTile(
              title: '$_languageTitle',
              subtitle: '$_languageSubtitle',
              leading: Icon(Icons.language),
              onPressed: (context) {
               /* Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => LanguagesScreen(),
                ));*/
                Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagesScreen())).then((value) async {
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
                });
              },
            ),
            SettingsTile.switchTile(
              title: '$_nightModeTitle',
              leading: Icon(Icons.phonelink_lock),
              switchValue: nightMode,
              onToggle: (bool value) {
                setState(() {
                  nightMode = value;
                });
              },
            ),
            SettingsTile(
              title: '$_envTitle',
              subtitle: '$_envSubTitle',
              leading: Icon(Icons.cloud_queue),
            ),
          ],
        ),
        SettingsSection(
          title: '$_settingsSectionMisc',
          tiles: [
            SettingsTile(
                title: '$_devLicenceTitle',
                leading: Icon(Icons.collections_bookmark)),
          ],
        ),
        CustomSection(
          child: Column(
            children: [
              /*Padding(
                *//*padding: const EdgeInsets.only(top: 22, bottom: 8),
                child: Image.asset(
                  'assets/settings.png',
                  height: 50,
                  width: 50,
                  color: Color(0xFF777777),
                ),*//*
              ),*/
              Text(
                '$_versionTitle : $_versionNumber',
                style: TextStyle(color: Color(0xFF777777)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
