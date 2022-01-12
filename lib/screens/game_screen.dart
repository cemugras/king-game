import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:king_game/models/constants.dart';
import 'package:king_game/services/cacheService.dart';
import 'package:king_game/services/contentService.dart';
import 'package:king_game/services/gameService.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

enum RadioButtons { firstRadio, secondRadio, thirdRadio, fourthRadio, fifthRadio, sixthRadio, seventhRadio, nullRadio }

//TODO - AppBar Summary and List Showing feature.
//TODO - Turn and points logic. (Arrays can be usable)

class _GameScreenState extends  State<GameScreen>{
  bool _nightMode = false;
  String _pageName = "game";
  String _language = "EN";
  String _appBarTitle = "";
  Color _appBarBackground = Colors.red, _bodyBackground = Colors.white, _text = Colors.black,
      _headingColor = Colors.blue, _heading = Colors.blue, _headingV2 = Colors.green,
      _playerOneBorderColor = Colors.black38, _playerTwoBorderColor = Colors.black38, _playerThreeBorderColor = Colors.black38, _playerFourBorderColor = Colors.black38,
      playerOneBorderColor = Colors.black38, playerTwoBorderColor = Colors.black38, playerThreeBorderColor = Colors.black38, playerFourBorderColor = Colors.black38;
  String _playerOneName = "Player-1", _playerTwoName = "Player-2", _playerThreeName = "Player-3", _playerFourName = "Player-4",
      _playerTurn = "Player-1",
      _playerOnePointName = "PointPlayer-1", _playerTwoPointName = "PointPlayer-2", _playerThreePointName = "PointPlayer-3", _playerFourPointName = "PointPlayer-4";
  int _turn = 1, _turnPrev = 1;
  double _playerOneBorderWidth = 1, _playerTwoBorderWidth = 1, _playerThreeBorderWidth = 1, _playerFourBorderWidth = 1,
      playerOneBorderWidth = 1, playerTwoBorderWidth = 1, playerThreeBorderWidth = 1, playerFourBorderWidth = 1;

  bool _firstRadio = true, _secondRadio = true, _thirdRadio = true, _fourthRadio = true, _fifthRadio = true, _sixthRadio = true, _seventhRadio = true;

  int _pointPlayerOne = 0, _pointPlayerTwo = 0, _pointPlayerThree = 0, _pointPlayerFour = 0,
      _totalPointPlayerOne = 0, _totalPointPlayerTwo = 0, _totalPointPlayerThree = 0, _totalPointPlayerFour = 0;
  int _playerOneTrick = 0, _playerTwoTrick = 0, _playerThreeTrick = 0, _playerFourTrick = 0, _totalTrickCount = 0, _maxTrickCount = 0;
  int _noTricksMax = 2, _noManMax = 2, _noQueenMax = 2, _noHeartMax = 2, _noHeartKingMax = 2, _noLast2Max = 2,
      _noTricksRemain = 2, _noManRemain = 2, _noQueenRemain = 2, _noHeartRemain = 2, _noHeartKingRemain = 2, _noLast2Remain = 2,
      _firstPlayerTrumpMax = 2, _secondPlayerTrumpMax = 2, _thirdPlayerTrumpMax = 2, _fourthPlayerTrumpMax = 2,
      _firstPlayerTrumpRemain = 2, _secondPlayerTrumpRemain = 2, _thirdPlayerTrumpRemain = 2, _fourthPlayerTrumpRemain = 2;

  String _selectedGame = "null", _turnName = "Turn-",
      _firstGameName = "noTricksTitle", _secondGameName = "noManTitle", _thirdGameName = "noQueenTitle", _fourthGameName = "noHeartTitle", _fifthGameName = "noHeartKingTitle", _sixthGameName = "noLast2Title", _seventhGameName = "trumpTitle";

  TextEditingController _playerOne = new TextEditingController();
  TextEditingController _playerTwo = new TextEditingController();
  TextEditingController _playerThree = new TextEditingController();
  TextEditingController _playerFour = new TextEditingController();

  RadioButtons _selectedRadio = RadioButtons.nullRadio;

  //Icons with logic variables
  static const IconData circle_empty = IconData(0xf10c, fontFamily: 'Fonts', fontPackage: null);
  static const IconData circle = IconData(0xf111, fontFamily: 'Fonts', fontPackage: null);
  static const IconData trashIcon = IconData(0xe535, fontFamily: 'MaterialIcons');
  IconData _pOneIcon1 = circle_empty, _pOneIcon2 = circle_empty, _pOneIcon3 = circle_empty, _pOneIcon4 = circle_empty, _pOneIcon5 = circle_empty,
      _pTwoIcon1 = circle_empty, _pTwoIcon2 = circle_empty, _pTwoIcon3 = circle_empty, _pTwoIcon4 = circle_empty, _pTwoIcon5 = circle_empty,
      _pThreeIcon1 = circle_empty, _pThreeIcon2 = circle_empty, _pThreeIcon3 = circle_empty, _pThreeIcon4 = circle_empty, _pThreeIcon5 = circle_empty,
      _pFourIcon1 = circle_empty, _pFourIcon2 = circle_empty, _pFourIcon3 = circle_empty, _pFourIcon4 = circle_empty, _pFourIcon5 = circle_empty;
  int _pOneRedCounter = 0, _pOneCounter = 0, _pTwoRedCounter = 0, _pTwoCounter = 0, _pThreeRedCounter = 0, _pThreeCounter = 0, _pFourRedCounter = 0, _pFourCounter = 0;

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
      _headingV2 = ContentService().getContentColor("headingV2", _nightMode);
    });
  }

  void _getPlayerDataList() async {
    List<String> playerList = await GameService().getPlayerNameList("PlayerList");
    setState(() {
      if(playerList.length > 0) {
        _playerOneName = playerList[0];
        _playerTwoName = playerList[1];
        _playerThreeName = playerList[2];
        _playerFourName = playerList[3];
      }
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

  void _refreshTurnData() async {
    _turn = await GameService().getTurnCount();
    String playerTurn = _getPlayerTurn();
    int _playerOnePoint = await GameService().getPlayerTotalPoint(_playerOnePointName);
    int _playerTwoPoint = await GameService().getPlayerTotalPoint(_playerTwoPointName);
    int _playerThreePoint = await GameService().getPlayerTotalPoint(_playerThreePointName);
    int _playerFourPoint = await GameService().getPlayerTotalPoint(_playerFourPointName);

    if (playerTurn == "Player-1"){
      _playerTurn             = _playerOneName;
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
      _playerTurn             = _playerTwoName;
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
      _playerTurn             = _playerThreeName;
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
      _playerTurn             = _playerFourName;
      playerOneBorderColor    = Colors.black38;
      playerTwoBorderColor    = Colors.black38;
      playerThreeBorderColor  = Colors.black38;
      playerFourBorderColor   = Colors.red;
      playerOneBorderWidth    = 1;
      playerTwoBorderWidth    = 1;
      playerThreeBorderWidth  = 1;
      playerFourBorderWidth   = 3;
    }

    if(_turn>1) {
      _noTricksRemain           = 2;
      _noManRemain              = 2;
      _noQueenRemain            = 2;
      _noHeartRemain            = 2;
      _noHeartKingRemain        = 2;
      _noLast2Remain            = 2;
      _firstPlayerTrumpRemain   = 2;
      _secondPlayerTrumpRemain  = 2;
      _thirdPlayerTrumpRemain   = 2;
      _fourthPlayerTrumpRemain  = 2;
      _pOneRedCounter           = 0;
      _pOneCounter              = 0;
      _pTwoRedCounter           = 0;
      _pTwoCounter              = 0;
      _pThreeRedCounter         = 0;
      _pThreeCounter            = 0;
      _pFourRedCounter          = 0;
      _pFourCounter             = 0;
      for(int i=1; i<_turn; i++){
        _turnName = "Turn-";
        _turnName = _turnName + "$i";
        List<String> dataList = await GameService().getTurnDataList(_turnName);
        String _gameName = dataList[0];
        String _player = dataList[5];
        if(_gameName == _firstGameName) {
          if (_player == "Player-1"){ //Icon Logic Player One
            if (_pOneRedCounter == 0)
              _pOneIcon1 = circle;
            else if (_pOneRedCounter == 1)
              _pOneIcon2 = circle;
            else
              _pOneIcon3 = circle;
            _pOneRedCounter = _pOneRedCounter + 1;
          }
          if (_player == "Player-2"){ //Icon Logic Player Two
            if (_pTwoRedCounter == 0)
              _pTwoIcon1 = circle;
            else if (_pTwoRedCounter == 1)
              _pTwoIcon2 = circle;
            else
              _pTwoIcon3 = circle;
            _pTwoRedCounter = _pTwoRedCounter + 1;
          }
          if (_player == "Player-3"){ //Icon Logic Player One
            if (_pThreeRedCounter == 0)
              _pThreeIcon1 = circle;
            else if (_pThreeRedCounter == 1)
              _pThreeIcon2 = circle;
            else
              _pThreeIcon3 = circle;
            _pThreeRedCounter = _pThreeRedCounter + 1;
          }
          if (_player == "Player-4"){ //Icon Logic Player One
            if (_pFourRedCounter == 0)
              _pFourIcon1 = circle;
            else if (_pFourRedCounter == 1)
              _pFourIcon2 = circle;
            else
              _pFourIcon3 = circle;
            _pFourRedCounter = _pFourRedCounter + 1;
          }
          _noTricksRemain = _noTricksRemain - 1;
        }else if(_gameName == _secondGameName) {
          if (_player == "Player-1"){ //Icon Logic Player One
            if (_pOneRedCounter == 0)
              _pOneIcon1 = circle;
            else if (_pOneRedCounter == 1)
              _pOneIcon2 = circle;
            else
              _pOneIcon3 = circle;
            _pOneRedCounter = _pOneRedCounter + 1;
          }
          if (_player == "Player-2"){ //Icon Logic Player Two
            if (_pTwoRedCounter == 0)
              _pTwoIcon1 = circle;
            else if (_pTwoRedCounter == 1)
              _pTwoIcon2 = circle;
            else
              _pTwoIcon3 = circle;
            _pTwoRedCounter = _pTwoRedCounter + 1;
          }
          if (_player == "Player-3"){ //Icon Logic Player One
            if (_pThreeRedCounter == 0)
              _pThreeIcon1 = circle;
            else if (_pThreeRedCounter == 1)
              _pThreeIcon2 = circle;
            else
              _pThreeIcon3 = circle;
            _pThreeRedCounter = _pThreeRedCounter + 1;
          }
          if (_player == "Player-4"){ //Icon Logic Player One
            if (_pFourRedCounter == 0)
              _pFourIcon1 = circle;
            else if (_pFourRedCounter == 1)
              _pFourIcon2 = circle;
            else
              _pFourIcon3 = circle;
            _pFourRedCounter = _pFourRedCounter + 1;
          }
          _noManRemain = _noManRemain - 1;
        }else if(_gameName == _thirdGameName) {
          if (_player == "Player-1"){ //Icon Logic Player One
            if (_pOneRedCounter == 0)
              _pOneIcon1 = circle;
            else if (_pOneRedCounter == 1)
              _pOneIcon2 = circle;
            else
              _pOneIcon3 = circle;
            _pOneRedCounter = _pOneRedCounter + 1;
          }
          if (_player == "Player-2"){ //Icon Logic Player Two
            if (_pTwoRedCounter == 0)
              _pTwoIcon1 = circle;
            else if (_pTwoRedCounter == 1)
              _pTwoIcon2 = circle;
            else
              _pTwoIcon3 = circle;
            _pTwoRedCounter = _pTwoRedCounter + 1;
          }
          if (_player == "Player-3"){ //Icon Logic Player One
            if (_pThreeRedCounter == 0)
              _pThreeIcon1 = circle;
            else if (_pThreeRedCounter == 1)
              _pThreeIcon2 = circle;
            else
              _pThreeIcon3 = circle;
            _pThreeRedCounter = _pThreeRedCounter + 1;
          }
          if (_player == "Player-4"){ //Icon Logic Player One
            if (_pFourRedCounter == 0)
              _pFourIcon1 = circle;
            else if (_pFourRedCounter == 1)
              _pFourIcon2 = circle;
            else
              _pFourIcon3 = circle;
            _pFourRedCounter = _pFourRedCounter + 1;
          }
          _noQueenRemain = _noQueenRemain - 1;
        }else if(_gameName == _fourthGameName) {
          if (_player == "Player-1"){ //Icon Logic Player One
            if (_pOneRedCounter == 0)
              _pOneIcon1 = circle;
            else if (_pOneRedCounter == 1)
              _pOneIcon2 = circle;
            else
              _pOneIcon3 = circle;
            _pOneRedCounter = _pOneRedCounter + 1;
          }
          if (_player == "Player-2"){ //Icon Logic Player Two
            if (_pTwoRedCounter == 0)
              _pTwoIcon1 = circle;
            else if (_pTwoRedCounter == 1)
              _pTwoIcon2 = circle;
            else
              _pTwoIcon3 = circle;
            _pTwoRedCounter = _pTwoRedCounter + 1;
          }
          if (_player == "Player-3"){ //Icon Logic Player One
            if (_pThreeRedCounter == 0)
              _pThreeIcon1 = circle;
            else if (_pThreeRedCounter == 1)
              _pThreeIcon2 = circle;
            else
              _pThreeIcon3 = circle;
            _pThreeRedCounter = _pThreeRedCounter + 1;
          }
          if (_player == "Player-4"){ //Icon Logic Player One
            if (_pFourRedCounter == 0)
              _pFourIcon1 = circle;
            else if (_pFourRedCounter == 1)
              _pFourIcon2 = circle;
            else
              _pFourIcon3 = circle;
            _pFourRedCounter = _pFourRedCounter + 1;
          }
          _noHeartRemain = _noHeartRemain - 1;
        }else if(_gameName == _fifthGameName) {
          if (_player == "Player-1"){ //Icon Logic Player One
            if (_pOneRedCounter == 0)
              _pOneIcon1 = circle;
            else if (_pOneRedCounter == 1)
              _pOneIcon2 = circle;
            else
              _pOneIcon3 = circle;
            _pOneRedCounter = _pOneRedCounter + 1;
          }
          if (_player == "Player-2"){ //Icon Logic Player Two
            if (_pTwoRedCounter == 0)
              _pTwoIcon1 = circle;
            else if (_pTwoRedCounter == 1)
              _pTwoIcon2 = circle;
            else
              _pTwoIcon3 = circle;
            _pTwoRedCounter = _pTwoRedCounter + 1;
          }
          if (_player == "Player-3"){ //Icon Logic Player One
            if (_pThreeRedCounter == 0)
              _pThreeIcon1 = circle;
            else if (_pThreeRedCounter == 1)
              _pThreeIcon2 = circle;
            else
              _pThreeIcon3 = circle;
            _pThreeRedCounter = _pThreeRedCounter + 1;
          }
          if (_player == "Player-4"){ //Icon Logic Player One
            if (_pFourRedCounter == 0)
              _pFourIcon1 = circle;
            else if (_pFourRedCounter == 1)
              _pFourIcon2 = circle;
            else
              _pFourIcon3 = circle;
            _pFourRedCounter = _pFourRedCounter + 1;
          }
          _noHeartKingRemain = _noHeartKingRemain - 1;
        }else if(_gameName == _sixthGameName) {
          if (_player == "Player-1"){ //Icon Logic Player One
            if (_pOneRedCounter == 0)
              _pOneIcon1 = circle;
            else if (_pOneRedCounter == 1)
              _pOneIcon2 = circle;
            else
              _pOneIcon3 = circle;
            _pOneRedCounter = _pOneRedCounter + 1;
          }
          if (_player == "Player-2"){ //Icon Logic Player Two
            if (_pTwoRedCounter == 0)
              _pTwoIcon1 = circle;
            else if (_pTwoRedCounter == 1)
              _pTwoIcon2 = circle;
            else
              _pTwoIcon3 = circle;
            _pTwoRedCounter = _pTwoRedCounter + 1;
          }
          if (_player == "Player-3"){ //Icon Logic Player One
            if (_pThreeRedCounter == 0)
              _pThreeIcon1 = circle;
            else if (_pThreeRedCounter == 1)
              _pThreeIcon2 = circle;
            else
              _pThreeIcon3 = circle;
            _pThreeRedCounter = _pThreeRedCounter + 1;
          }
          if (_player == "Player-4"){ //Icon Logic Player One
            if (_pFourRedCounter == 0)
              _pFourIcon1 = circle;
            else if (_pFourRedCounter == 1)
              _pFourIcon2 = circle;
            else
              _pFourIcon3 = circle;
            _pFourRedCounter = _pFourRedCounter + 1;
          }
          _noLast2Remain = _noLast2Remain - 1;
        }else {
          if (_player == "Player-1"){
            _firstPlayerTrumpRemain = _firstPlayerTrumpRemain - 1;
            if (_pOneCounter == 0) //Icon Logic Player One
              _pOneIcon4 = circle;
            else
              _pOneIcon5 = circle;
            _pOneCounter = _pOneCounter + 1;
          } else if (_player == "Player-2"){
            _secondPlayerTrumpRemain = _secondPlayerTrumpRemain - 1;
            if (_pTwoCounter == 0) //Icon Logic Player Two
              _pTwoIcon4 = circle;
            else
              _pTwoIcon5 = circle;
            _pTwoCounter = _pTwoCounter + 1;
          } else if (_player == "Player-3"){
            _thirdPlayerTrumpRemain = _thirdPlayerTrumpRemain - 1;
            if (_pThreeCounter == 0) //Icon Logic Player Three
              _pThreeIcon4 = circle;
            else
              _pThreeIcon5 = circle;
            _pThreeCounter = _pThreeCounter + 1;
          } else if (_player == "Player-4"){
            _fourthPlayerTrumpRemain = _fourthPlayerTrumpRemain - 1;
            if (_pFourCounter == 0) //Icon Logic Player Four
              _pFourIcon4 = circle;
            else
              _pFourIcon5 = circle;
            _pFourCounter = _pFourCounter + 1;
          }
        }
      }
    }
    _refreshFormData();
    setState(() {
      _playerOneBorderColor   = playerOneBorderColor;
      _playerTwoBorderColor   = playerTwoBorderColor;
      _playerThreeBorderColor = playerThreeBorderColor;
      _playerFourBorderColor  = playerFourBorderColor;
      _playerOneBorderWidth   = playerOneBorderWidth;
      _playerTwoBorderWidth   = playerTwoBorderWidth;
      _playerThreeBorderWidth = playerThreeBorderWidth;
      _playerFourBorderWidth  = playerFourBorderWidth;

      _totalPointPlayerOne = _playerOnePoint;
      _totalPointPlayerTwo = _playerTwoPoint;
      _totalPointPlayerThree = _playerThreePoint;
      _totalPointPlayerFour = _playerFourPoint;

    });
  }

  void _gameSelectionDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _bodyBackground,
          content: Stack(
            children: <Widget>[
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            enabled: false,
                            title: InkWell(
                              borderRadius: BorderRadius.circular(40),
                              child: Text(_turn.toString() + " " + ContentService().getContent(_language, "alertPlayingTurn") + _playerTurn, textAlign: TextAlign.center),
                            ),
                          ),
                          ListTile(
                            enabled: _firstRadio,
                            title: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  setState(() {
                                    if(_firstRadio){
                                      _selectedRadio = RadioButtons.firstRadio;
                                      _selectedGame = _firstGameName;
                                    }
                                  });
                                },
                                child: Text(ContentService().getContent(_language, "noTricksTitle"))),
                            leading: Radio(
                              value: RadioButtons.firstRadio,
                              groupValue: _selectedRadio,
                              onChanged: (RadioButtons? value) {
                                setState(() {
                                  if(_firstRadio) {
                                    _selectedRadio = value!;
                                    _selectedGame = _firstGameName;
                                  }
                                });
                              },
                            ),
                          ),
                          ListTile(
                            enabled: _secondRadio,
                            title: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  setState(() {
                                    if(_secondRadio){
                                      _selectedRadio = RadioButtons.secondRadio;
                                      _selectedGame = _secondGameName;
                                    }
                                  });
                                },
                                child: Text(ContentService().getContent(_language, "noManTitle"))),
                            leading: Radio(
                              value: RadioButtons.secondRadio,
                              groupValue: _selectedRadio,
                              onChanged: (RadioButtons? value) {
                                setState(() {
                                  if(_secondRadio) {
                                    _selectedRadio = value!;
                                    _selectedGame = _secondGameName;
                                  }
                                });
                              },
                            ),
                          ),
                          ListTile(
                            enabled: _thirdRadio,
                            title: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  setState(() {
                                    if(_thirdRadio){
                                      _selectedRadio = RadioButtons.thirdRadio;
                                      _selectedGame = _thirdGameName;
                                    }
                                  });
                                },
                                child: Text(ContentService().getContent(_language, "noQueenTitle"))),
                            leading: Radio(
                              value: RadioButtons.thirdRadio,
                              groupValue: _selectedRadio,
                              onChanged: (RadioButtons? value) {
                                setState(() {
                                  if(_thirdRadio) {
                                    _selectedRadio = value!;
                                    _selectedGame = _thirdGameName;
                                  }
                                });
                              },
                            ),
                          ),
                          ListTile(
                            enabled: _fourthRadio,
                            title: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  setState(() {
                                    if(_fourthRadio){
                                      _selectedRadio = RadioButtons.fourthRadio;
                                      _selectedGame = _fourthGameName;
                                    }
                                  });
                                },
                                child: Text(ContentService().getContent(_language, "noHeartTitle"))),
                            leading: Radio(
                              value: RadioButtons.fourthRadio,
                              groupValue: _selectedRadio,
                              onChanged: (RadioButtons? value) {
                                setState(() {
                                  if(_fourthRadio) {
                                    _selectedRadio = value!;
                                    _selectedGame = _fourthGameName;
                                  }
                                });
                              },
                            ),
                          ),
                          ListTile(
                            enabled: _fifthRadio,
                            title: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  setState(() {
                                    if(_fifthRadio){
                                      _selectedRadio = RadioButtons.fifthRadio;
                                      _selectedGame = _fifthGameName;
                                    }
                                  });
                                },
                                child: Text(ContentService().getContent(_language, "noHeartKingTitle"))),
                            leading: Radio(
                              value: RadioButtons.fifthRadio,
                              groupValue: _selectedRadio,
                              onChanged: (RadioButtons? value) {
                                setState(() {
                                  if(_fifthRadio) {
                                    _selectedRadio = value!;
                                    _selectedGame = _fifthGameName;
                                  }
                                });
                              },
                            ),
                          ),
                          ListTile(
                            enabled: _sixthRadio,
                            title: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  setState(() {
                                    if(_sixthRadio){
                                      _selectedRadio = RadioButtons.sixthRadio;
                                      _selectedGame = _sixthGameName;
                                    }
                                  });
                                },
                                child: Text(ContentService().getContent(_language, "noLast2Title"))),
                            leading: Radio(
                              value: RadioButtons.sixthRadio,
                              groupValue: _selectedRadio,
                              onChanged: (RadioButtons? value) {
                                setState(() {
                                  if(_sixthRadio) {
                                    _selectedRadio = value!;
                                    _selectedGame = _sixthGameName;
                                  }
                                });
                              },
                            ),
                          ),
                          ListTile(
                            enabled: _seventhRadio,
                            title: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  setState(() {
                                    if(_seventhRadio){
                                      _selectedRadio = RadioButtons.seventhRadio;
                                      _selectedGame = _seventhGameName;
                                    }
                                  });
                                },
                                child: Text(ContentService().getContent(_language, "trumpTitle"))),
                            leading: Radio(
                              value: RadioButtons.seventhRadio,
                              groupValue: _selectedRadio,
                              onChanged: (RadioButtons? value) {
                                setState(() {
                                  if(_seventhRadio) {
                                    _selectedRadio = value!;
                                    _selectedGame = _seventhGameName;
                                  }
                                });
                              },
                            ),
                          ),
                          Wrap(
                            children: <Widget>[
                              ElevatedButton(
                                child: Text(ContentService().getMenuTitleContent(_language, "cancelTitle")),
                                style: ElevatedButton.styleFrom(
                                    primary: _bodyBackground,
                                    onPrimary: _heading,
                                    shadowColor: _bodyBackground,
                                    elevation: 0
                                ),
                                onPressed: () {
                                  _resetGameFormText();
                                  Navigator.pop(context);
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
                                  if(_selectedRadio != RadioButtons.nullRadio){
                                    _resetGameFormText();
                                    _calculateMaxTrick();
                                    Navigator.of(context).pop();
                                    _pointSelectionDialog(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        );
      },
    );
  }

  void _pointSelectionDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _bodyBackground,
          content: Stack(
            children: <Widget>[
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                              enabled: false,
                              title: Text(ContentService().getContent(_language, "alertSelectedGame") + ContentService().getContent(_language, _selectedGame), textAlign: TextAlign.center)
                          ),
                          Container(
                            height: 70,
                            child: new Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if(_playerOneTrick > 0 && _totalTrickCount > 0) {
                                            _playerOneTrick = _playerOneTrick - 1;
                                            _totalTrickCount = _totalTrickCount -1;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.arrow_back, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      _playerOneName,
                                      style: TextStyle(
                                        color: _text,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _playerOneTrick.toString(),
                                      style: TextStyle(
                                        color: _text,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if(_totalTrickCount < _maxTrickCount) {
                                            _playerOneTrick = _playerOneTrick + 1;
                                            _totalTrickCount = _totalTrickCount + 1;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.arrow_forward, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 70,
                            child: new Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if(_playerTwoTrick > 0 && _totalTrickCount > 0) {
                                            _playerTwoTrick = _playerTwoTrick - 1;
                                            _totalTrickCount = _totalTrickCount -1;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.arrow_back, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      _playerTwoName,
                                      style: TextStyle(
                                        color: _text,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _playerTwoTrick.toString(),
                                      style: TextStyle(
                                        color: _text,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if(_totalTrickCount < _maxTrickCount) {
                                            _playerTwoTrick = _playerTwoTrick + 1;
                                            _totalTrickCount = _totalTrickCount + 1;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.arrow_forward, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 70,
                            child: new Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if(_playerThreeTrick > 0 && _totalTrickCount > 0) {
                                            _playerThreeTrick = _playerThreeTrick - 1;
                                            _totalTrickCount = _totalTrickCount -1;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.arrow_back, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      _playerThreeName,
                                      style: TextStyle(
                                        color: _text,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _playerThreeTrick.toString(),
                                      style: TextStyle(
                                        color: _text,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if(_totalTrickCount < _maxTrickCount) {
                                            _playerThreeTrick = _playerThreeTrick + 1;
                                            _totalTrickCount = _totalTrickCount + 1;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.arrow_forward, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 70,
                            child: new Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if(_playerFourTrick > 0 && _totalTrickCount > 0) {
                                            _playerFourTrick = _playerFourTrick - 1;
                                            _totalTrickCount = _totalTrickCount -1;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.arrow_back, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      _playerFourName,
                                      style: TextStyle(
                                        color: _text,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _playerFourTrick.toString(),
                                      style: TextStyle(
                                        color: _text,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if(_totalTrickCount < _maxTrickCount) {
                                            _playerFourTrick = _playerFourTrick + 1;
                                            _totalTrickCount = _totalTrickCount + 1;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.arrow_forward, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Wrap(
                            children: <Widget>[
                              ElevatedButton(
                                child: Text(ContentService().getMenuTitleContent(_language, "cancelTitle")),
                                style: ElevatedButton.styleFrom(
                                    primary: _bodyBackground,
                                    onPrimary: _heading,
                                    shadowColor: _bodyBackground,
                                    elevation: 0
                                ),
                                onPressed: () {
                                  _resetGameFormText();
                                  Navigator.pop(context);
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
                                  if(_totalTrickCount == _maxTrickCount && _selectedRadio != RadioButtons.nullRadio){
                                    Navigator.of(context).pop();
                                    _insertPlayerPoints();
                                    _resetGameFormText();
                                    _refreshTurnData();
                                    //_refreshFormData();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        );
      },
    );
  }

  void _refreshFormData() async {
    _selectedRadio = RadioButtons.nullRadio;
    if(_turn < 5)
      _seventhRadio = false;
    else
      _seventhRadio = true;
    if(_noTricksRemain == 0)
      _firstRadio = false;
    if(_noManRemain == 0)
      _secondRadio = false;
    if(_noQueenRemain == 0)
      _thirdRadio = false;
    if(_noHeartRemain == 0)
      _fourthRadio = false;
    if(_noHeartKingRemain == 0)
      _fifthRadio = false;
    if(_noLast2Remain == 0)
      _sixthRadio = false;
    if (_playerTurn == "Player-1"){
      if(_firstPlayerTrumpRemain == 0)
        _seventhRadio = false;
    }
    else if (_playerTurn == "Player-2"){
      if(_secondPlayerTrumpRemain == 0)
        _seventhRadio = false;
    }
    else if (_playerTurn == "Player-3"){
      if(_thirdPlayerTrumpRemain == 0)
        _seventhRadio = false;
    }
    else if (_playerTurn == "Player-4"){
      if(_fourthPlayerTrumpRemain == 0)
        _seventhRadio = false;
    }
  }

  void _resetGameFormText() async {
    //_selectedRadio = RadioButtons.nullRadio;
    _playerOne.text='';
    _playerTwo.text='';
    _playerThree.text='';
    _playerFour.text='';
    _playerOneTrick = 0;
    _playerTwoTrick = 0;
    _playerThreeTrick = 0;
    _playerFourTrick = 0;
  }

  void _insertPlayerPoints() async {
    setState(() {
      _pointPlayerOne     = 0;
      _pointPlayerTwo     = 0;
      _pointPlayerThree   = 0;
      _pointPlayerFour    = 0;
      if(_selectedGame == _firstGameName) {
        _pointPlayerOne   = _playerOneTrick    * Constants.POINT_NO_TRICKS;
        _pointPlayerTwo   = _playerTwoTrick    * Constants.POINT_NO_TRICKS;
        _pointPlayerThree = _playerThreeTrick  * Constants.POINT_NO_TRICKS;
        _pointPlayerFour  = _playerFourTrick   * Constants.POINT_NO_TRICKS;
      }else if(_selectedGame == _secondGameName) {
        _pointPlayerOne   = _playerOneTrick    * Constants.POINT_NO_MAN;
        _pointPlayerTwo   = _playerTwoTrick    * Constants.POINT_NO_MAN;
        _pointPlayerThree = _playerThreeTrick  * Constants.POINT_NO_MAN;
        _pointPlayerFour  = _playerFourTrick   * Constants.POINT_NO_MAN;
      }else if(_selectedGame == _thirdGameName) {
        _pointPlayerOne   = _playerOneTrick    * Constants.POINT_NO_QUEEN;
        _pointPlayerTwo   = _playerTwoTrick    * Constants.POINT_NO_QUEEN;
        _pointPlayerThree = _playerThreeTrick  * Constants.POINT_NO_QUEEN;
        _pointPlayerFour  = _playerFourTrick   * Constants.POINT_NO_QUEEN;
      }else if(_selectedGame == _fourthGameName) {
        _pointPlayerOne   = _playerOneTrick    * Constants.POINT_NO_HEART;
        _pointPlayerTwo   = _playerTwoTrick    * Constants.POINT_NO_HEART;
        _pointPlayerThree = _playerThreeTrick  * Constants.POINT_NO_HEART;
        _pointPlayerFour  = _playerFourTrick   * Constants.POINT_NO_HEART;
      }else if(_selectedGame == _fifthGameName) {
        _pointPlayerOne   = _playerOneTrick    * Constants.POINT_NO_HEART_KING;
        _pointPlayerTwo   = _playerTwoTrick    * Constants.POINT_NO_HEART_KING;
        _pointPlayerThree = _playerThreeTrick  * Constants.POINT_NO_HEART_KING;
        _pointPlayerFour  = _playerFourTrick   * Constants.POINT_NO_HEART_KING;
      }else if(_selectedGame == _sixthGameName) {
        _pointPlayerOne   = _playerOneTrick    * Constants.POINT_NO_LAST_2;
        _pointPlayerTwo   = _playerTwoTrick    * Constants.POINT_NO_LAST_2;
        _pointPlayerThree = _playerThreeTrick  * Constants.POINT_NO_LAST_2;
        _pointPlayerFour  = _playerFourTrick   * Constants.POINT_NO_LAST_2;
        _noLast2Remain = _noLast2Remain - 1;
      }else {
        _pointPlayerOne   = _playerOneTrick    * Constants.POINT_TRUMP;
        _pointPlayerTwo   = _playerTwoTrick    * Constants.POINT_TRUMP;
        _pointPlayerThree = _playerThreeTrick  * Constants.POINT_TRUMP;
        _pointPlayerFour  = _playerFourTrick   * Constants.POINT_TRUMP;
        /*if (_playerTurn == "Player-1"){
          _firstPlayerTrumpRemain = _firstPlayerTrumpRemain - 1;
        } else if (_playerTurn == "Player-2"){
          _secondPlayerTrumpRemain = _secondPlayerTrumpRemain - 1;
        } else if (_playerTurn == "Player-3"){
          _secondPlayerTrumpRemain = _secondPlayerTrumpRemain - 1;
        } else if (_playerTurn == "Player-4"){
          _secondPlayerTrumpRemain = _secondPlayerTrumpRemain - 1;
        }*/
      }
      _totalPointPlayerOne     = _totalPointPlayerOne       + _pointPlayerOne;
      _totalPointPlayerTwo     = _totalPointPlayerTwo       + _pointPlayerTwo;
      _totalPointPlayerThree   = _totalPointPlayerThree     + _pointPlayerThree;
      _totalPointPlayerFour    = _totalPointPlayerFour      + _pointPlayerFour;

      _turnName = "Turn-";
      _turnName = _turnName + "$_turn";
      List<String> dataList = [_selectedGame, _pointPlayerOne.toString(), _pointPlayerTwo.toString(), _pointPlayerThree.toString(), _pointPlayerFour.toString(),_playerTurn];
      GameService().setTurnData(_turnName, dataList);

      _turn = _turn + 1;
      GameService().setTurnCount(_turn);
      GameService().setPlayerTotalPoint(_playerOnePointName, _totalPointPlayerOne);
      GameService().setPlayerTotalPoint(_playerTwoPointName, _totalPointPlayerTwo);
      GameService().setPlayerTotalPoint(_playerThreePointName, _totalPointPlayerThree);
      GameService().setPlayerTotalPoint(_playerFourPointName, _totalPointPlayerFour);
    });
  }

  void _calculateMaxTrick() async {
    if(_selectedGame == _firstGameName) {
      _maxTrickCount = 13;
    }else if(_selectedGame == _secondGameName) {
      _maxTrickCount = 8;
    }else if(_selectedGame == _thirdGameName) {
      _maxTrickCount = 4;
    }else if(_selectedGame == _fourthGameName) {
      _maxTrickCount = 13;
    }else if(_selectedGame == _fifthGameName) {
      _maxTrickCount = 1;
    }else if(_selectedGame == _sixthGameName) {
      _maxTrickCount = 2;
    }else {
      _maxTrickCount = 13;
    }
    _totalTrickCount = 0;
  }

  @override
  void initState() {
    super.initState();
    _getLanguage();
    _getDarkTheme();
    _getPlayerDataList();
    _refreshTurnData();
    //_refreshFormData();
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
                onTap: () {
                  _gameSelectionDialog(context);
                },
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
              child: new Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(_pOneIcon1, size: 14, color: Colors.red),
                      Icon(_pOneIcon2, size: 14, color: Colors.red),
                      Icon(_pOneIcon3, size: 14, color: Colors.red)
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(_pOneIcon4, size: 14, color: _headingV2),
                      Icon(_pOneIcon5, size: 14, color: _headingV2)
                    ],
                  ),
                  SizedBox(width: 20),
                  Text(
                    _playerOneName,
                    style: TextStyle(
                      color: _text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _totalPointPlayerOne.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                ],
              ),
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
              child: new Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(_pTwoIcon1, size: 14, color: Colors.red),
                      Icon(_pTwoIcon2, size: 14, color: Colors.red),
                      Icon(_pTwoIcon3, size: 14, color: Colors.red)
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(_pTwoIcon4, size: 14, color: _headingV2),
                      Icon(_pTwoIcon5, size: 14, color: _headingV2)
                    ],
                  ),
                  SizedBox(width: 20),
                  Text(
                    _playerTwoName,
                    style: TextStyle(
                      color: _text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _totalPointPlayerTwo.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                ],
              ),
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
              child: new Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(_pThreeIcon1, size: 14, color: Colors.red),
                      Icon(_pThreeIcon2, size: 14, color: Colors.red),
                      Icon(_pThreeIcon3, size: 14, color: Colors.red)
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(_pThreeIcon4, size: 14, color: _headingV2),
                      Icon(_pThreeIcon5, size: 14, color: _headingV2)
                    ],
                  ),
                  SizedBox(width: 20),
                  Text(
                    _playerThreeName,
                    style: TextStyle(
                      color: _text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _totalPointPlayerThree.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                ],
              ),
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
              child: new Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(_pFourIcon1, size: 14, color: Colors.red),
                      Icon(_pFourIcon2, size: 14, color: Colors.red),
                      Icon(_pFourIcon3, size: 14, color: Colors.red)
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(_pFourIcon4, size: 14, color: _headingV2),
                      Icon(_pFourIcon5, size: 14, color: _headingV2)
                    ],
                  ),
                  SizedBox(width: 20),
                  Text(
                    _playerFourName,
                    style: TextStyle(
                      color: _text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _totalPointPlayerFour.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: _bodyBackground,
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                    color: _headingV2,
                    width: 2
                ),
              ),
              child: new Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(ContentService().getContent(_language, "noTricksTitle")      + " : " + _noTricksRemain.toString()),
                      Text(ContentService().getContent(_language, "noManTitle")         + " : " + _noManRemain.toString()),
                      Text(ContentService().getContent(_language, "noQueenTitle")       + " : " + _noQueenRemain.toString()),
                      Text(ContentService().getContent(_language, "noHeartTitle")       + " : " + _noHeartRemain.toString()),
                      Text(ContentService().getContent(_language, "noHeartKingTitle")   + " : " + _noHeartKingRemain.toString()),
                      Text(ContentService().getContent(_language, "noLast2Title")       + " : " + _noLast2Remain.toString())
                    ],
                  ),
                  SizedBox(width: 50),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(_playerOneName     + " " + ContentService().getContent(_language, "trumpTitle") + " : " + _firstPlayerTrumpRemain.toString()),
                      Text(_playerTwoName     + " " + ContentService().getContent(_language, "trumpTitle") + " : " + _secondPlayerTrumpRemain.toString()),
                      Text(_playerThreeName   + " " + ContentService().getContent(_language, "trumpTitle") + " : " + _thirdPlayerTrumpRemain.toString()),
                      Text(_playerFourName    + " " + ContentService().getContent(_language, "trumpTitle") + " : " + _fourthPlayerTrumpRemain.toString()),
                    ],
                  ),
                ],
              ),
            )
          ]
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 75.0,
        color: _appBarBackground,
        child: Padding(
          padding: EdgeInsets.only(right: 5.0, left: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _playerOneName,
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _totalPointPlayerOne.toString(),
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _playerTwoName,
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _totalPointPlayerTwo.toString(),
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _playerThreeName,
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _totalPointPlayerThree.toString(),
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _playerFourName,
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _totalPointPlayerFour.toString(),
                        style: TextStyle(
                          color: _text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
