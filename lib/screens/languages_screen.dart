import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:king_game/services/contentService.dart';
import 'package:king_game/services/cacheService.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  int languageIndex = 0;
  String pageName = "language", _language = "NULL";
  String title = "null";

  @override
  void initState() {
    super.initState();
    _getLanguage();
  }

  void _changeLanguage(String languagePref, int index) {
    setState(() {
      languageIndex = index;
      CacheService().setStringValue('language', languagePref);
      _getLanguage();
    });
  }

  void _getLanguage() async {
    setState(() {
      _language = CacheService().getStringValue("language").then((String value) {
        setState(() {
          title = ContentService().getAppBarTitle(value.toString(), pageName);
        });
      }) as String;
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
          '$title',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: "English",
              trailing: trailingWidget(0),
              onPressed: (BuildContext context) {
                _changeLanguage("EN" , 0);
              },
            ),
            SettingsTile(
              title: "Türkçe",
              trailing: trailingWidget(1),
              onPressed: (BuildContext context) {
                _changeLanguage("TR" , 1);
              },
            )
          ]),
        ],
      ),
    );
  }

  Widget trailingWidget(int index) {
    return (languageIndex == index)
        ? Icon(Icons.check, color: Colors.blue)
        : Icon(null);
  }

  /*String getLanguage(){
    language = ContentService().getAppBarTitle(CacheService().getLanguage(), pageName);
    return language;
  }*/
}