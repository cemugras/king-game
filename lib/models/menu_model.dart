import 'package:flutter/material.dart';

class Option {
  Image icon;
  String title;
  String subtitle;
  Color textColor, backgroundColor;

  Option({required this.icon,
    required this.title,
    required this.subtitle,
    required this.textColor,
    required this.backgroundColor});
}

class Turkish{
  String title;
  String subtitle;

  Turkish({required this.title,
    required this.subtitle});
}

final turkish = [
  Turkish(
      title: 'King Skor Tablosu',
      subtitle: 'King skor hesaplayıcı.'
  ),
  Turkish(
      title: 'Yeni Oyun',
      subtitle: 'King skoru için yeni oyun kur.'
  ),
  Turkish(
    title: '   Son Oyun',
    subtitle: '   Son oynanan oyunun bilgileri.'
  ),
  Turkish(
    title: '   Kurallar',
    subtitle: '   Kurallar kataloğu.'
  ),
  Turkish(
    title: '   Ayarlar',
    subtitle: '   Ayarları düzenle.'
  )
];

class English{
  String title;
  String subtitle;

  English({required this.title,
    required this.subtitle});
}

final english = [
  English(
      title: 'King Score Table',
      subtitle: 'King score calculator.'
  ),
  English(
      title: 'New Game',
      subtitle: 'Create a game for King scores.'
  ),
  English(
      title: '   Last Game',
      subtitle: '   Last game information.'
  ),
  English(
      title: '   Rules',
      subtitle: '   Game rule catalog.'
  ),
  English(
      title: '   Settings',
      subtitle: '   Configure settings.'
  )
];

final options = [
  Option(
    //icon: Icon(Icons.bakery_dining, size: 50.0),
    icon: new Image.asset("./lib/assets/card_deck.png"),
    title: 'New Game',
    subtitle: 'Creates a new game for King.',
    textColor: Colors.white,
    backgroundColor: Colors.red,
  ),
  Option(
    //icon: Icon(Icons.change_circle_sharp, size: 50.0),
    icon: new Image.asset("./lib/assets/prev_game.png"),
    title: '   Last Game',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
    textColor: Colors.black,
    backgroundColor: Colors.orange,
  ),
  Option(
    //icon: Icon(Icons.chat_outlined, size: 50.0),
    icon: new Image.asset('./lib/assets/rules.png'),
    title: '   Rules',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
    textColor: Colors.white,
    backgroundColor: Colors.blueAccent,
  ),
  Option(
    //icon: Icon(Icons.build_circle, size: 50.0),
    icon: new Image.asset('./lib/assets/settings.png'),
    title: '   Settings',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
    textColor: Colors.black,
    backgroundColor: Colors.yellowAccent,
  )
];

List<Map> _languageJson = [
  {
    "id": 0,
    "image": "./lib/assets/turkish_flag.png",
    "name": "TR"
  },
  {
    "id": 1,
    "image": "./lib/assets/eng_flag.png",
    "name": "EN"
  }
];