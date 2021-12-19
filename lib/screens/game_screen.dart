import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:king_game/services/cacheService.dart';
import 'package:king_game/services/contentService.dart';
import 'package:king_game/services/gameService.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

//TODO - AppBar Summary and List Showing feature.
//TODO - Turn and points logic. (Arrays can be usable)

class _GameScreenState extends  State<GameScreen>{
  bool _nightMode = false;
  String _pageName = "game";
  String _language = "EN";
  String _appBarTitle = "";
  Color _appBarBackground = Colors.red, _bodyBackground = Colors.white, _text = Colors.black, _whiteText = Colors.white,
      _headingColor = Colors.blue, _heading = Colors.blue,
      _playerOneBorderColor = Colors.black38, _playerTwoBorderColor = Colors.black38, _playerThreeBorderColor = Colors.black38, _playerFourBorderColor = Colors.black38,
      playerOneBorderColor = Colors.black38, playerTwoBorderColor = Colors.black38, playerThreeBorderColor = Colors.black38, playerFourBorderColor = Colors.black38;
  String _playerOneName = "Player-1", _playerTwoName = "Player-2", _playerThreeName = "Player-3", _playerFourName = "Player-4",
      _playerTurn = "Player-1";
  int _turn = 1;
  double _playerOneBorderWidth = 1, _playerTwoBorderWidth = 1, _playerThreeBorderWidth = 1, _playerFourBorderWidth = 1,
      playerOneBorderWidth = 1, playerTwoBorderWidth = 1, playerThreeBorderWidth = 1, playerFourBorderWidth = 1;

  static const IconData trashIcon = IconData(0xe535, fontFamily: 'MaterialIcons');

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

  void _getPlayerDataList() async {
    List<String> playerList = await GameService().getPlayerNameList("PlayerList");
    setState(() {
      if(playerList.length > 0)
        _playerOneName = playerList[0];
        _playerTwoName = playerList[1];
        _playerThreeName = playerList[2];
        _playerFourName = playerList[3];
    });
  }

  String _getPlayerTurn() {
    if (_turn % 4 == 0)
      return "Player-4";
    else if (_turn % 2 == 0)
      return "Player-2";
    else if (_turn == 3 || (_turn % 4) - 3 == 0)
      return "Player-3";
    else
      return "Player-1";
  }

  void _refreshTurnData() {
    String playerTurn = _getPlayerTurn();

    if (playerTurn == "Player-1"){
      playerOneBorderColor    = Colors.red;
      playerTwoBorderColor    = Colors.black38;
      playerThreeBorderColor  = Colors.black38;
      playerFourBorderColor   = Colors.black38;
      playerOneBorderWidth    = 3;
      playerTwoBorderWidth    = 1;
      playerThreeBorderWidth  = 1;
      playerFourBorderWidth   = 1;
    }
    else if (playerTurn == "Player-2"){
      playerOneBorderColor    = Colors.black38;
      playerTwoBorderColor    = Colors.red;
      playerThreeBorderColor  = Colors.black38;
      playerFourBorderColor   = Colors.black38;
      playerOneBorderWidth    = 1;
      playerTwoBorderWidth    = 3;
      playerThreeBorderWidth  = 1;
      playerFourBorderWidth   = 1;
    }
    else if (playerTurn == "Player-3"){
      playerOneBorderColor    = Colors.black38;
      playerTwoBorderColor    = Colors.black38;
      playerThreeBorderColor  = Colors.red;
      playerFourBorderColor   = Colors.black38;
      playerOneBorderWidth    = 1;
      playerTwoBorderWidth    = 1;
      playerThreeBorderWidth  = 3;
      playerFourBorderWidth   = 1;
    }
    else if (playerTurn == "Player-4"){
      playerOneBorderColor    = Colors.black38;
      playerTwoBorderColor    = Colors.black38;
      playerThreeBorderColor  = Colors.black38;
      playerFourBorderColor   = Colors.red;
      playerOneBorderWidth    = 1;
      playerTwoBorderWidth    = 1;
      playerThreeBorderWidth  = 1;
      playerFourBorderWidth   = 3;
    }
    setState(() {
      _playerTurn = playerTurn;
      _playerOneBorderColor   = playerOneBorderColor;
      _playerTwoBorderColor   = playerTwoBorderColor;
      _playerThreeBorderColor = playerThreeBorderColor;
      _playerFourBorderColor  = playerFourBorderColor;
      _playerOneBorderWidth   = playerOneBorderWidth;
      _playerTwoBorderWidth   = playerTwoBorderWidth;
      _playerThreeBorderWidth = playerThreeBorderWidth;
      _playerFourBorderWidth  = playerFourBorderWidth;
    });
  }

  @override
  void initState() {
    super.initState();
    _getLanguage();
    _getDarkTheme();
    _getPlayerDataList();
    _refreshTurnData();
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
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  trashIcon,
                  size: 26.0,
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                    Icons.add_circle_outline_rounded
                ),
              )
          ),
        ],
      ),
        body: ListView(
            children: <Widget> [
              Container(
                  height: 70,
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      color: _bodyBackground,
                      borderRadius: BorderRadius.circular(45.0),
                    border: Border.all(
                        color: _playerOneBorderColor,
                        width: _playerOneBorderWidth
                    ),
                  ),
                  child: ListTile(
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
                    border: Border.all(
                        color: _playerTwoBorderColor,
                        width: _playerTwoBorderWidth
                    ),
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
                    border: Border.all(
                        color: _playerThreeBorderColor,
                        width: _playerThreeBorderWidth
                    ),
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
                    border: Border.all(
                        color: _playerFourBorderColor,
                        width: _playerFourBorderWidth
                    ),
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
