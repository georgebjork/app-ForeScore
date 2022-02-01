
import 'package:flutter/cupertino.dart';
import '../Match.dart';
import '../constants.dart';

class MatchProvider extends ChangeNotifier{

  late Match match;
  int currentHole = 0;

  MatchProvider();

  void nextHole(){
    if(currentHole < 17){
      currentHole++;
      notifyListeners();
    }
  }

  void prevHole(){
    if(currentHole > 0){
      currentHole --;
      notifyListeners();
    }
  }

  String displayCurrentHole(){
    int hole = currentHole+1;
    return "Hole " + hole.toString();
  }

  String displayHoleDetails(){
    String par = match.teeBox.holes[currentHole].par.toString();
    String hdcp = match.teeBox.holes[currentHole].handicap.toString();

    return "Par: " + par + " | " + "Hdcp: " + hdcp;
  }


  void setMatch(Match m){
    match = m;
  }

  void postHoleScore(int playerId, int holeId, int matchId, int score) async {
    //First post the hole score to the db
    final updatedMatch = await service.postHoleScore(playerId, holeId, matchId, score);

    //Then update the local match
    match = updatedMatch;
    
    notifyListeners();   

  }
}