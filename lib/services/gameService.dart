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

  void setPlayerNameList(String key, List<String> playerList) {
    CacheService().setStringList(key, playerList);
  }
  void setTurnData(String key, List<String> turnData) {
    CacheService().setStringList(key, turnData);
  }

  void setTurnCount(int value) {
    CacheService().setIntValue("turnCount", value);
  }

  Future<String> getPlayerName(String playerNumber) async {
    final playerName = await CacheService().getStringValue(playerNumber);
    return playerName;
  }

  Future<List<String>> getPlayerNameList(String playerNumber) async {
    List<String> playerName = await CacheService().getStringList(playerNumber);
    return playerName;
  }

  Future<List<String>> getTurnData(String key) async {
    List<String> turnData = await CacheService().getStringList(key);
    return turnData;
  }

  Future<int> getTurnCount() async {
    int turnCount = await CacheService().getIntValue("turnCount");
    return turnCount;
  }

}
