import 'cacheService.dart';

class GameService {
  Future<bool> isGameExist() async {
    final game = await CacheService().getBooleanValue("game");
    return game;
  }

  void setGameTrue() {
    CacheService().setBooleanValue("game", true);
  }

  void setGameFalse() {
    CacheService().setBooleanValue("game", false);
  }

  void setPlayerName(String playerName, String playerNumber) {
    CacheService().setStringValue(playerNumber, playerName);
  }

  void setPlayerNameList(String playerNumber, List<String> playerList) {
    CacheService().setStringList(playerNumber, playerList);
  }

  Future<String> getPlayerName(String playerNumber) async {
    final playerName = await CacheService().getStringValue(playerNumber);
    return playerName;
  }

  Future<List<String>> getPlayerNameList(String playerNumber) async {
    List<String> playerName = await CacheService().getStringList(playerNumber);
    return playerName;
  }

}
