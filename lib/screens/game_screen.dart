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
      _headingColor = Colors.blue, _heading = Colors.blue,
      _playerOneBorderColor = Colors.black38, _playerTwoBorderColor = Colors.black38, _playerThreeBorderColor = Colors.black38, _playerFourBorderColor = Colors.black38,
      playerOneBorderColor = Colors.black38, playerTwoBorderColor = Colors.black38, playerThreeBorderColor = Colors.black38, playerFourBorderColor = Colors.black38;
  String _playerOneName = "Player-1", _playerTwoName = "Player-2", _playerThreeName = "Player-3", _playerFourName = "Player-4",
      _playerTurn = "Player-1";
  int _turn = 1;
  double _playerOneBorderWidth = 1, _playerTwoBorderWidth = 1, _playerThreeBorderWidth = 1, _playerFourBorderWidth = 1,
      playerOneBorderWidth = 1, playerTwoBorderWidth = 1, playerThreeBorderWidth = 1, playerFourBorderWidth = 1;

  bool _firstRadio = true, _secondRadio = true, _thirdRadio = true, _fourthRadio = true, _fifthRadio = true, _sixthRadio = true, _seventhRadio = true;

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

  AlertDialog _newTurnForm() {
    return AlertDialog(
      backgroundColor: _bodyBackground,
      content: Stack(
        children: <Widget>[
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
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
                );
                return Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
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
                            child: Text(ContentService().getContent(_language, "noLast2Title"))),
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
              /*Container(
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
              ),*/
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
                        Icon(circle_empty, size: 14, color: Colors.green),
                        Icon(circle, size: 14, color: Colors.green)
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
