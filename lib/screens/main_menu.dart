import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:king_game/models/menu_model.dart';
import 'package:king_game/screens/settings_screen.dart';
import 'package:king_game/services/contentService.dart';
import 'package:king_game/services/cacheService.dart';

class MainMenu extends StatefulWidget{
  @override
  _MainMenu createState() => _MainMenu();
}

class _MainMenu extends State<MainMenu>{
  bool _nightMode = false;
  String pageName = "menu";
  String _language = "EN";
  String _appBarTitle = "";
  Color _appBarBackground = Colors.red, _bodyBackground = Colors.white, _heading = Colors.blue, _text = Colors.black;

  void _getLanguage() async {
    _language = await CacheService().getStringValue("language");
    setState(() {
      _appBarTitle = ContentService().getAppBarTitle(_language.toString(), pageName);
    });
  }

  void _getDarkTheme() async {
    final nightMode = await ContentService().getDarkTheme();
    setState(() {
      _nightMode = nightMode;
      _appBarBackground = ContentService().getContentColor("appBarBackground", _nightMode);
      _bodyBackground = ContentService().getContentColor("mainBodyBackground", _nightMode);
      _heading = ContentService().getContentColor("heading", _nightMode);
      _text = ContentService().getContentColor("text", _nightMode);
    });
  }

  @override
  void initState() {
    super.initState();
    _getLanguage();
    _getDarkTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bodyBackground,
      appBar: AppBar(
        backgroundColor: _appBarBackground,
        centerTitle: true,
        title: Text(
          '$_appBarTitle',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
    body: ListView.builder(
        itemCount: options.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SizedBox(height: 15.0);
          } else if (index == options.length + 1) {
            return SizedBox(height: 100.0);
          }
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(4.0),
            /*width: double.infinity,*/
            height: 70.0,
            decoration: BoxDecoration(
                color: options[index - 1].backgroundColor,
                borderRadius: BorderRadius.circular(45.0),
                border: Border.all(color: Colors.black38)
            ),
              child: ListTile(
                  leading: options[index - 1].icon,
                title: Text(
                  ContentService().getMenuTitle(_language, index),
                  style: TextStyle(
                    color: options[index - 1].textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    ContentService().getMenuSubtitle(_language, index),
                  style: TextStyle(color: options[index - 1].textColor)
                ),
                selected: true, //icon showing active
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen())).then((value) async {
                    _getLanguage();
                    _getDarkTheme();
                  });
                    setState(() {
                  });
                },
              ),
          );
        }
    ),
      /*bottomSheet: Container(
        width: double.infinity,
        height: 200.0,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'SAVE & CONTINUE',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 18.0,
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}