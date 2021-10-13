import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:king_game/services/cacheService.dart';
import 'package:king_game/services/contentService.dart';
import 'package:king_game/services/gameService.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends  State<GameScreen>{
  bool _nightMode = false;
  String _pageName = "game";
  String _language = "EN";
  String _appBarTitle = "";
  Color _appBarBackground = Colors.red, _bodyBackground = Colors.white, _text = Colors.black, _whiteText = Colors.white,
      _headingColor = Colors.blue, _heading = Colors.blue;
  String _playerOneName = "Player-1", _playerTwoName = "Player-2", _playerThreeName = "Player-3", _playerFourName = "Player-4";

  void _getLanguage() async {
    _language = await CacheService().getStringValue("language");
    setState(() {
      _appBarTitle = ContentService().getAppBarTitle(_language.toString(), _pageName);
    });
  }

  void _getDarkTheme() async {
    final nightMode = await ContentService().getDarkTheme();
    setState(() {
      _nightMode = nightMode;
      _appBarBackground = ContentService().getContentColor("appBarBackground", _nightMode);
      _bodyBackground = ContentService().getContentColor("mainBodyBackground", _nightMode);
      _text = ContentService().getContentColor("text", _nightMode);
      _heading = ContentService().getContentColor("heading", _nightMode);
    });
  }

  void _getPlayerData() async {
    final playerOneName = await GameService().getPlayerName("playerOne");
    final playerTwoName = await GameService().getPlayerName("playerTwo");
    final playerThreeName = await GameService().getPlayerName("playerThree");
    final playerFourName = await GameService().getPlayerName("playerFour");
    setState(() {
      _playerOneName = playerOneName;
      _playerTwoName = playerTwoName;
      _playerThreeName = playerThreeName;
      _playerFourName = playerFourName;
    });
  }

  @override
  void initState() {
    super.initState();
    _getLanguage();
    _getDarkTheme();
    _getPlayerData();
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
        body: ListView(
            children: <Widget> [
              Container(
                  height: 70,
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      color: _bodyBackground,
                      borderRadius: BorderRadius.circular(45.0),
                      border: Border.all(color: Colors.black38)
                  ),
                  child: ListTile(
                    //leading: new Image.asset("./lib/assets/card_deck.png"),
                    title: Text(
                      _playerOneName,
                      style: TextStyle(
                        color: _text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
              ),
              Container(
                  height: 70,
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      color: _bodyBackground,
                      borderRadius: BorderRadius.circular(45.0),
                      border: Border.all(color: Colors.black38)
                  ),
                  child: ListTile(
                    //leading: new Image.asset("./lib/assets/card_deck.png"),
                    title: Text(
                      _playerTwoName,
                      style: TextStyle(
                        color: _text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
              ),
              Container(
                  height: 70,
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      color: _bodyBackground,
                      borderRadius: BorderRadius.circular(45.0),
                      border: Border.all(color: Colors.black38)
                  ),
                  child: ListTile(
                    //leading: new Image.asset("./lib/assets/card_deck.png"),
                    title: Text(
                      _playerThreeName,
                      style: TextStyle(
                        color: _text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
              ),
              Container(
                  height: 70,
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      color: _bodyBackground,
                      borderRadius: BorderRadius.circular(45.0),
                      border: Border.all(color: Colors.black38)
                  ),
                  child: ListTile(
                    //leading: new Image.asset("./lib/assets/card_deck.png"),
                    title: Text(
                      _playerFourName,
                      style: TextStyle(
                        color: _text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
              )
            ]
        )
    );
  }

}
