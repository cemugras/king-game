import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      _playerTurn = "Player-1";
  int _turn = 1;
  double _playerOneBorderWidth = 1, _playerTwoBorderWidth = 1, _playerThreeBorderWidth = 1, _playerFourBorderWidth = 1,
      playerOneBorderWidth = 1, playerTwoBorderWidth = 1, playerThreeBorderWidth = 1, playerFourBorderWidth = 1;

  bool _firstRadio = true, _secondRadio = true, _thirdRadio = true, _fourthRadio = true, _fifthRadio = true, _sixthRadio = true, _seventhRadio = true;

  int _pointPlayerOne = 0, _pointPlayerTwo = 0, _pointPlayerThree = 0, _pointPlayerFour = 0;

  String _selectedGame = "null",
      _firstRadioName = "noTricksTitle", _secondRadioName = "noManTitle", _thirdRadioName = "noQueenTitle", _fourthRadioName = "noHeartTitle", _fifthRadioName = "noHeartKingTitle", _sixthRadioName = "noLast2Title", _seventhRadioName = "trumpTitle";

  TextEditingController _playerOne = new TextEditingController();
  TextEditingController _playerTwo = new TextEditingController();
  TextEditingController _playerThree = new TextEditingController();
  TextEditingController _playerFour = new TextEditingController();

  RadioButtons _selectedRadio = RadioButtons.nullRadio;

  static const IconData circle_empty = IconData(0xf10c, fontFamily: 'Fonts', fontPackage: null);
  static const IconData circle = IconData(0xf111, fontFamily: 'Fonts', fontPackage: null);

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
      _headingV2 = ContentService().getContentColor("headingV2", _nightMode);
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

  void _refreshTurnData() async {
    _turn = await GameService().getTurnCount();
    String playerTurn = _getPlayerTurn();

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
    setState(() {
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

  AlertDialog _newTurnForm() {
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
                          onTap: () {
                            setState(() {
                              if(_firstRadio)
                                _selectedRadio = RadioButtons.firstRadio;
                            });
                          },
                          child: Text(_turn.toString() + " " + ContentService().getContent(_language, "alertPlayingTurn") + _playerTurn, textAlign: TextAlign.center),
                        ),
                      ),
                      ListTile(
                        enabled: _firstRadio,
                        title: InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {
                              setState(() {
                                if(_firstRadio)
                                  _selectedRadio = RadioButtons.firstRadio;
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
                                _selectedGame = _firstRadioName;
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
                                if(_secondRadio)
                                  _selectedRadio = RadioButtons.secondRadio;
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
                                _selectedGame = _secondRadioName;
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
                                if(_thirdRadio)
                                  _selectedRadio = RadioButtons.thirdRadio;
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
                                _selectedGame = _thirdRadioName;
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
                                if(_fourthRadio)
                                  _selectedRadio = RadioButtons.fourthRadio;
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
                                _selectedGame = _fourthRadioName;
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
                                if(_fifthRadio)
                                  _selectedRadio = RadioButtons.fifthRadio;
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
                                _selectedGame = _fifthRadioName;
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
                                if(_sixthRadio)
                                  _selectedRadio = RadioButtons.sixthRadio;
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
                                _selectedGame = _sixthRadioName;
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
                                if(_seventhRadio)
                                  _selectedRadio = RadioButtons.seventhRadio;
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
                                _selectedGame = _seventhRadioName;
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
                              Navigator.pop(context);
                              _selectedRadio = RadioButtons.nullRadio;
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
                              if(_selectedRadio != RadioButtons.nullRadio){
                                Navigator.of(context).pop();

                                _resetGameFormText();
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen())).then((value) async {});
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return _newTurnFormV2();
                                    });
                                setState(() {
                                });
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
  }

  AlertDialog _newTurnFormV2() {
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
                          onTap: () {
                            setState(() {
                              if(_firstRadio)
                                _selectedRadio = RadioButtons.firstRadio;
                            });
                          },
                          child: Text(ContentService().getContent(_language, "alertSelectedGame") + ContentService().getContent(_language, _selectedGame), textAlign: TextAlign.center),
                        ),
                      ),
                      ListTile(
                        enabled: _firstRadio,
                        title: InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {
                              setState(() {
                                if(_firstRadio)
                                  _selectedRadio = RadioButtons.firstRadio;
                              });
                            },
                            child: Text(ContentService().getContent(_language, "noTricksTitle"))),
                        leading: Radio(
                          value: RadioButtons.firstRadio,
                          groupValue: _selectedRadio,
                          onChanged: (RadioButtons? value) {
                            setState(() {
                              if(_firstRadio)
                                _selectedRadio = value!;
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
                                if(_secondRadio)
                                  _selectedRadio = RadioButtons.secondRadio;
                              });
                            },
                            child: Text(ContentService().getContent(_language, "noManTitle"))),
                        leading: Radio(
                          value: RadioButtons.secondRadio,
                          groupValue: _selectedRadio,
                          onChanged: (RadioButtons? value) {
                            setState(() {
                              if(_secondRadio)
                                _selectedRadio = value!;
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
                                if(_thirdRadio)
                                  _selectedRadio = RadioButtons.thirdRadio;
                              });
                            },
                            child: Text(ContentService().getContent(_language, "noQueenTitle"))),
                        leading: Radio(
                          value: RadioButtons.thirdRadio,
                          groupValue: _selectedRadio,
                          onChanged: (RadioButtons? value) {
                            setState(() {
                              if(_thirdRadio)
                                _selectedRadio = value!;
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
                                if(_fourthRadio)
                                  _selectedRadio = RadioButtons.fourthRadio;
                              });
                            },
                            child: Text(ContentService().getContent(_language, "noHeartTitle"))),
                        leading: Radio(
                          value: RadioButtons.fourthRadio,
                          groupValue: _selectedRadio,
                          onChanged: (RadioButtons? value) {
                            setState(() {
                              if(_fourthRadio)
                                _selectedRadio = value!;
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
                                if(_fifthRadio)
                                  _selectedRadio = RadioButtons.fifthRadio;
                              });
                            },
                            child: Text(ContentService().getContent(_language, "noHeartKingTitle"))),
                        leading: Radio(
                          value: RadioButtons.fifthRadio,
                          groupValue: _selectedRadio,
                          onChanged: (RadioButtons? value) {
                            setState(() {
                              if(_fifthRadio)
                                _selectedRadio = value!;
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
                                if(_sixthRadio)
                                  _selectedRadio = RadioButtons.sixthRadio;
                              });
                            },
                            child: Text(ContentService().getContent(_language, "noLast2Title"))),
                        leading: Radio(
                          value: RadioButtons.sixthRadio,
                          groupValue: _selectedRadio,
                          onChanged: (RadioButtons? value) {
                            setState(() {
                              if(_sixthRadio)
                                _selectedRadio = value!;
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
                                if(_seventhRadio)
                                  _selectedRadio = RadioButtons.seventhRadio;
                              });
                            },
                            child: Text(ContentService().getContent(_language, "trumpTitle"))),
                        leading: Radio(
                          value: RadioButtons.seventhRadio,
                          groupValue: _selectedRadio,
                          onChanged: (RadioButtons? value) {
                            setState(() {
                              if(_seventhRadio)
                                _selectedRadio = value!;
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
                              Navigator.pop(context);
                              _selectedRadio = RadioButtons.nullRadio;
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
                              if(_selectedRadio != RadioButtons.nullRadio){
                                Navigator.of(context).pop();

                                _resetGameFormText();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen())).then((value) async {});
                                setState(() {
                                });
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
  }

  void _refreshFormData() async {
    if(_turn < 5)
      _seventhRadio = false;
  }

  void _resetGameFormText() async {
    _playerOne.text='';
    _playerTwo.text='';
    _playerThree.text='';
    _playerFour.text='';
  }

  @override
  void initState() {
    super.initState();
    _getLanguage();
    _getDarkTheme();
    _getPlayerDataList();
    _refreshTurnData();
    _refreshFormData();
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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _newTurnForm();
                      });
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
                      Icon(circle_empty, size: 14, color: Colors.red),
                      Icon(circle_empty, size: 14, color: Colors.red),
                      Icon(circle, size: 14, color: Colors.red)
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(circle_empty, size: 14, color: _headingV2),
                      Icon(circle, size: 14, color: _headingV2)
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
                        _pointPlayerOne.toString(),
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
                      Icon(circle_empty, size: 14, color: Colors.red),
                      Icon(circle_empty, size: 14, color: Colors.red),
                      Icon(circle, size: 14, color: Colors.red)
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(circle_empty, size: 14, color: _headingV2),
                      Icon(circle, size: 14, color: _headingV2)
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
                        _pointPlayerTwo.toString(),
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
                      Icon(circle_empty, size: 14, color: Colors.red),
                      Icon(circle_empty, size: 14, color: Colors.red),
                      Icon(circle, size: 14, color: Colors.red)
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(circle_empty, size: 14, color: _headingV2),
                      Icon(circle, size: 14, color: _headingV2)
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
                        _pointPlayerThree.toString(),
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
                      Icon(circle_empty, size: 14, color: Colors.red),
                      Icon(circle_empty, size: 14, color: Colors.red),
                      Icon(circle, size: 14, color: Colors.red)
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(circle_empty, size: 14, color: _headingV2),
                      Icon(circle, size: 14, color: _headingV2)
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
                        _pointPlayerFour.toString(),
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
                        _pointPlayerOne.toString(),
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
                        _pointPlayerTwo.toString(),
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
                        _pointPlayerThree.toString(),
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
                        _pointPlayerFour.toString(),
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
