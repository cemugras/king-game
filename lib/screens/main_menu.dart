import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:king_game/screens/rule_screen.dart';
import 'package:king_game/screens/settings_screen.dart';
import 'package:king_game/services/contentService.dart';
import 'package:king_game/services/cacheService.dart';
import 'package:king_game/services/gameService.dart';

import 'game_screen.dart';

class MainMenu extends StatefulWidget{
  @override
  _MainMenu createState() => _MainMenu();
}

//TODO - New Game Creation logic. / isGameExists / playerScores / playedTurns
//TODO - Last Game screen and logic.
//TODO - Options for game rule changes.
//TODO - End of all - Logcat issue fixes.

class _MainMenu extends State<MainMenu>{
  bool _nightMode = false;
  String _pageName = "menu";
  String _language = "EN";
  String _appBarTitle = "";
  String _existingGameWarning = "";
  Color _appBarBackground = Colors.red, _bodyBackground = Colors.white, _text = Colors.black, _whiteText = Colors.white,
      _newGameBackground = Colors.red, _lastGameBackground = Colors.orange, _rulesBackground = Colors.blueAccent, _settingsBackground = Colors.yellowAccent,
      _headingColor = Colors.blue, _heading = Colors.blue;
  String _playerOneName = "Player-1", _playerTwoName = "Player-2", _playerThreeName = "Player-3", _playerFourName = "Player-4";
  bool _gameExists = false;
  TextEditingController _playerOne = new TextEditingController();
  TextEditingController _playerTwo = new TextEditingController();
  TextEditingController _playerThree = new TextEditingController();
  TextEditingController _playerFour = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _getLanguage() async {
    _language = await CacheService().getStringValue("language");
    setState(() {
      _appBarTitle = ContentService().getAppBarTitle(_language.toString(), _pageName);
      _existingGameWarning = ContentService().getContent(_language.toString(),"existingGameWarning");
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
      if (_nightMode == true){
        _newGameBackground = _appBarBackground;
        _lastGameBackground = _appBarBackground;
        _rulesBackground = _appBarBackground;
        _settingsBackground = _appBarBackground;
        _headingColor = _heading;
      }else{
        _newGameBackground = Colors.red;
        _lastGameBackground = Colors.orange;
        _rulesBackground = Colors.blueAccent;
        _settingsBackground = Colors.yellowAccent;
        _headingColor = Colors.blue;
      }
    });
  }

  void _setPlayerName() {
    List<String> _playerNameList = [""];
    if(_playerOne.text!="")
      _playerOneName = _playerOne.text;
    if(_playerTwo.text!="")
      _playerTwoName = _playerTwo.text;
    if(_playerThree.text!="")
      _playerThreeName = _playerThree.text;
    if(_playerFour.text!="")
      _playerFourName = _playerFour.text;
    setState(() {
      _playerNameList.clear();
      _playerNameList.addAll([_playerOneName, _playerTwoName, _playerThreeName, _playerFourName]);
      GameService().setPlayerNameList("PlayerList", _playerNameList);
      GameService().setGameTrue();
    });
  }

  void _isGameExists() async {
    final isGameExists = await GameService().isGameExist();
    setState(() {
      _gameExists = isGameExists;
    });
  }

  void _resetGameFormText() async {
    _playerOne.text='';
    _playerTwo.text='';
    _playerThree.text='';
    _playerFour.text='';
  }

  AlertDialog _gameStartForm() {
    return AlertDialog(
      backgroundColor: _bodyBackground,
      content: Stack(
        children: <Widget>[
          Positioned(
            right: -30.0,
            top: -30.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: _bodyBackground,
              ),
            ),
          ),
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  //width: 100.0,
                    height: 30,
                    child: TextField(
                        controller: _playerOne,
                        maxLength: 10,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle),
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            counterText: ''
                        ),
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black
                        )
                    )
                ),
                Container(
                  //width: 100.0,
                    height: 30,
                    child: TextField(
                        controller: _playerTwo,
                        maxLength: 10,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle),
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            counterText: ''
                        ),
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black
                        )
                    )
                ),
                Container(
                  //width: 100.0,
                    height: 30,
                    child: TextField(
                        controller: _playerThree,
                        maxLength: 10,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle),
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            counterText: ''
                        ),
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black
                        )
                    )
                ),
                Container(
                  //width: 100.0,
                    height: 30,
                    child: TextField(
                        controller: _playerFour,
                        maxLength: 10,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle),
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            counterText: ''
                        ),
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black
                        )
                    )
                ),
                Wrap(
                  children: <Widget>[
                    ElevatedButton(
                      child: Text(ContentService().getMenuTitleContent(_language, "cancelTitle")),
                      style: ElevatedButton.styleFrom(
                          primary: _bodyBackground,
                          onPrimary: _newGameBackground,
                          shadowColor: _bodyBackground,
                          elevation: 0
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _resetGameFormText();
                      },
                    ),
                    Container(
                      width: 5.0,
                    ),
                    ElevatedButton(
                      child: Text(ContentService().getMenuTitleContent(_language, "submitTitle")),
                      style: ElevatedButton.styleFrom(
                          primary: _bodyBackground,
                          onPrimary: _headingColor,
                          shadowColor: _bodyBackground,
                          elevation: 0
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _setPlayerName();
                        _resetGameFormText();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen())).then((value) async {});
                        setState(() {
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog _gameExistsForm() {
    return AlertDialog(
      content: Text(_existingGameWarning),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _gameStartForm();
                  });
            },
            child: const Text('OK')
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _getLanguage();
    _getDarkTheme();
    _isGameExists();
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
              color: _newGameBackground,
              borderRadius: BorderRadius.circular(45.0),
              border: Border.all(color: Colors.black38)
          ),
          child: ListTile(
            leading: new Image.asset("./lib/assets/card_deck.png"),
            title: Text(
              ContentService().getMenuTitleContent(_language, "newGameTitle"),
              style: TextStyle(
                color: _whiteText,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
                ContentService().getMenuSubtitleContent(_language, "newGameSubtitle"),
                style: TextStyle(color: _whiteText)
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    if(_gameExists)
                      return _gameExistsForm();
                    else
                      return _gameStartForm();
                  });
              }),
        ),
        Container(
          height: 70,
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
              color: _lastGameBackground,
              borderRadius: BorderRadius.circular(45.0),
              border: Border.all(color: Colors.black38)
          ),
          child: ListTile(
            leading: new Image.asset("./lib/assets/prev_game.png"),
            title: Text(
              ContentService().getMenuTitleContent(_language, "lastGameTitle"),
              style: TextStyle(
                color: _text,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
                ContentService().getMenuSubtitleContent(_language, "lastGameSubtitle"),
                style: TextStyle(color: _text)
            ),
          ),
        ),
        Container(
          height: 70,
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
              color: _rulesBackground,
              borderRadius: BorderRadius.circular(45.0),
              border: Border.all(color: Colors.black38)
          ),
          child: ListTile(
            leading: new Image.asset('./lib/assets/rules.png'),
            title: Text(
              ContentService().getMenuTitleContent(_language, "rulesTitle"),
              style: TextStyle(
                color: _whiteText,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
                ContentService().getMenuSubtitleContent(_language, "rulesSubtitle"),
                style: TextStyle(color: _whiteText)
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RuleScreen())).then((value) async {
                _getLanguage();
                _getDarkTheme();
              });
              setState(() {
              });
            },
          ),
        ),
        Container(
          height: 70,
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
              color: _settingsBackground,
              borderRadius: BorderRadius.circular(45.0),
              border: Border.all(color: Colors.black38)
          ),
          child: ListTile(
            leading: new Image.asset('./lib/assets/settings.png'),
            title: Text(
              ContentService().getMenuTitleContent(_language, "settingsTitle"),
              style: TextStyle(
                color: _text,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
                ContentService().getMenuSubtitleContent(_language, "settingsSubtitle"),
                style: TextStyle(color: _text)
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen())).then((value) async {
                _getLanguage();
                _getDarkTheme();
              });
              setState(() {
              });
            },
          ),
        ),
      ]
        /*itemCount: options.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SizedBox(height: 15.0);
          } else if (index == options.length + 1) {
            return SizedBox(height: 100.0);
          }
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(4.0),
            *//*width: double.infinity,*//*
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
        }*/
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
