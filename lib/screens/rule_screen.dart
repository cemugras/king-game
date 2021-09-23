import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:king_game/services/cacheService.dart';
import 'package:king_game/services/contentService.dart';

class RuleScreen extends StatefulWidget {
  @override
  _RuleScreenState createState() => _RuleScreenState();
}

class _RuleScreenState extends State<RuleScreen> {
  bool _nightMode = false;
  String _language = "EN";
  String pageName = "rules",
      _appBarTitle = "";
  Color _appBarBackground = Colors.red, _bodyBackground = Colors.white, _containerBackground = Colors.white, _text = Colors.black;

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
    });
  }

  void _getDarkTheme() async {
    final nightMode = await ContentService().getDarkTheme();
    setState(() {
      _nightMode = nightMode;
      _appBarBackground = ContentService().getContentColor("appBarBackground", _nightMode);
      _bodyBackground = ContentService().getContentColor("mainBodyBackground", _nightMode);
      _text = ContentService().getContentColor("text", _nightMode);
      if (_nightMode == true)
        _containerBackground = _appBarBackground;
    });
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
      body:
      ListView(
          children: <Widget> [
            Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: _containerBackground,
                  borderRadius: BorderRadius.horizontal(),
                  border: Border.all(color: Colors.black38)
              ),
              child: ListTile(
                title: Text(
                  ContentService().getContent(_language, "noTricksTitle"),
                  style: TextStyle(
                    color: _text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    ContentService().getContent(_language, "noTricksDescr"),
                    style: TextStyle(color: _text)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: _containerBackground,
                  borderRadius: BorderRadius.horizontal(),
                  border: Border.all(color: Colors.black38)
              ),
              child: ListTile(
                title: Text(
                  ContentService().getContent(_language, "noHeartTitle"),
                  style: TextStyle(
                    color: _text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    ContentService().getContent(_language, "noHeartDescr"),
                    style: TextStyle(color: _text)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: _containerBackground,
                  borderRadius: BorderRadius.horizontal(),
                  border: Border.all(color: Colors.black38)
              ),
              child: ListTile(
                title: Text(
                  ContentService().getContent(_language, "noManTitle"),
                  style: TextStyle(
                    color: _text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    ContentService().getContent(_language, "noManDescr"),
                    style: TextStyle(color: _text)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: _containerBackground,
                  borderRadius: BorderRadius.horizontal(),
                  border: Border.all(color: Colors.black38)
              ),
              child: ListTile(
                title: Text(
                  ContentService().getContent(_language, "noQueenTitle"),
                  style: TextStyle(
                    color: _text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    ContentService().getContent(_language, "noQueenDescr"),
                    style: TextStyle(color: _text)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: _containerBackground,
                  borderRadius: BorderRadius.horizontal(),
                  border: Border.all(color: Colors.black38)
              ),
              child: ListTile(
                title: Text(
                  ContentService().getContent(_language, "noLast2Title"),
                  style: TextStyle(
                    color: _text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    ContentService().getContent(_language, "noLast2Descr"),
                    style: TextStyle(color: _text)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: _containerBackground,
                  borderRadius: BorderRadius.horizontal(),
                  border: Border.all(color: Colors.black38)
              ),
              child: ListTile(
                title: Text(
                  ContentService().getContent(_language, "noHeartKingTitle"),
                  style: TextStyle(
                    color: _text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    ContentService().getContent(_language, "noHeartKingDescr"),
                    style: TextStyle(color: _text)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: _containerBackground,
                  borderRadius: BorderRadius.horizontal(),
                  border: Border.all(color: Colors.black38)
              ),
              child: ListTile(
                title: Text(
                  ContentService().getContent(_language, "trumpTitle"),
                  style: TextStyle(
                    color: _text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    ContentService().getContent(_language, "trumpDescr"),
                    style: TextStyle(color: _text)
                ),
              ),
            )
          ]
      ),
    );
  }
}