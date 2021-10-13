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

  Future<String> getPlayerName(String playerNumber) async {
    final playerName = await CacheService().getStringValue(playerNumber);
    return playerName;
  }

}
