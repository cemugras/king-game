import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:king_game/models/menu_model.dart';
import 'package:king_game/screens/settings_screen.dart';
import 'package:king_game/services/contentService.dart';


class MainMenu extends StatefulWidget{
  @override
  _MainMenu createState() => _MainMenu();
}

class _MainMenu extends State<MainMenu>{
  int _selectedOption = 0;
  String language = "TR", pageName = "menu";
  Image image = new Image.asset("./lib/assets/turkish_flag.png");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          ContentService().getAppBarTitle(language, pageName),
            /*"King Skor Tablosu",*/
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
                //color: Colors.red,
                color: options[index - 1].backgroundColor,
                borderRadius: BorderRadius.circular(45.0),
                border: Border.all(color: Colors.black38)
              //border: _selectedOption == index - 1 ? Border.all(color: Colors.black26) : null,
            ),
              child: ListTile(
                  leading: options[index - 1].icon,
                //Image.asset("lib/assets/card_deck.png"),
                title: Text(
                  ContentService().getMenuTitle(language, index),
                  /*options[index - 1].title,*/
                  style: TextStyle(
                    color: options[index - 1].textColor,
                    fontWeight: FontWeight.bold,
                    //color: _selectedOption == index - 1 ? Colors.black : Colors.grey[600],
                  ),
                ),
                subtitle: Text(
                    ContentService().getMenuSubtitle(language, index),
                  style: TextStyle(color: options[index - 1].textColor)
                ),
                selected: true, //icon showing active
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen()
                    )
                  );
                    setState(() {
                    _selectedOption = index - 1;
                  });
                },
              ),
          );
        }
    ),
      bottomSheet: Container(
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
      ),
    );
  }
}