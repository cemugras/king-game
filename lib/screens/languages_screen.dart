import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:king_game/services/contentService.dart';
import 'package:king_game/services/cacheService.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  bool _nightMode = false;
  int languageIndex = 0;
  String pageName = "language";
  late String _appBarTitle;
  late Color _appBarBackground, _bodyBackground, _heading, _text;

  @override
  void initState() {
    super.initState();
    _getLanguage();
    _getDarkTheme();
  }

  void _changeLanguage(String languagePref, int index) {
    setState(() {
      languageIndex = index;
      CacheService().setStringValue('language', languagePref);
      _getLanguage();
    });
  }

  void _getLanguage() async {
    final language = await CacheService().getStringValue("language");
    if(language == "TR")
      languageIndex = 1;
    else
      languageIndex = 0;
    final appBarTitle = ContentService().getAppBarTitle(language.toString(), pageName);
    setState(() {
      _appBarTitle = appBarTitle;
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
      body: SettingsList(
        backgroundColor: _bodyBackground,
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: "English",
              titleTextStyle: TextStyle(color: _text, fontWeight: FontWeight.bold),
              trailing: trailingWidget(0),
              onPressed: (BuildContext context) {
                _changeLanguage("EN" , 0);
                Navigator.pop(context);
              },
            ),
            SettingsTile(
              title: "Türkçe",
              titleTextStyle: TextStyle(color: _text, fontWeight: FontWeight.bold),
              trailing: trailingWidget(1),
              onPressed: (BuildContext context) {
                _changeLanguage("TR" , 1);
                Navigator.pop(context);
              },
            )
          ]),
        ],
      ),
    );
  }

  Widget trailingWidget(int index) {
    return (languageIndex == index)
        ? Icon(Icons.check, color: _heading)
        : Icon(null);
  }
}