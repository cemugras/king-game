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
  bool nightMode = false;
  late String _language;
  String pageName = "settings", title = "null";

  @override
  void initState() {
    super.initState();
    _getLanguage();
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
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'Common',
          tiles: [
            SettingsTile(
              title: 'Language',
              subtitle: 'Türkçe',
              leading: Icon(Icons.language),
              onPressed: (context) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => LanguagesScreen(),
                ));
              },
            ),
            SettingsTile.switchTile(
              title: 'Night Mode',
              leading: Icon(Icons.phonelink_lock),
              switchValue: nightMode,
              onToggle: (bool value) {
                setState(() {
                  nightMode = value;
                });
              },
            ),
            SettingsTile(
              title: 'Environment',
              subtitle: 'Production',
              leading: Icon(Icons.cloud_queue),
            ),
          ],
        ),
        SettingsSection(
          title: 'Misc',
          tiles: [
            SettingsTile(
                title: 'Developer licences',
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
                'Version: 1.0.0 (1)',
                style: TextStyle(color: Color(0xFF777777)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
