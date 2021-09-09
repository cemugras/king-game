import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:king_game/models/menu_model.dart';
import 'package:settings_ui/settings_ui.dart';

String getAppBarTitle(String language){
  if(language == 'TR'){
    return turkish[4].title;
  }else if(language == 'EN'){
    return english[4].title;
  }else
    return options[3].title;
}

class SettingsPage extends StatefulWidget{
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  static const keyDarkMode = 'key-dark-mode';
  static const keyLanguage = 'key-language';
  String language = "TR";
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xFFFAFAFA),
    appBar: AppBar(
      backgroundColor: Colors.red,
      centerTitle: true,
      title: Text(
        getAppBarTitle(language),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 28,
      ),
    ),
  ),
  body: ListView(
      children: [
        SettingsSection(
          title: 'General',
          tiles: [
            SettingsTile(title: 'Language',
              leading: Icon(Icons.language)
              ),
          ]
        )

      ],
  ),
  );


  /*Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          getAppBarTitle(language),
          *//*"King Skor Tablosu",*//*
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              SettingsGroup(
                title: 'GENERAL',
                children: <Widget>[],
              )
            ],
          )
      ),
    );
  }*/
}