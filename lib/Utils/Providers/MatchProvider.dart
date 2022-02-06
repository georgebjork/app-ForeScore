
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

  //This function will post a hole to the database
  void postHoleScore(int playerId, int score) async {
    //This will tell the api call to post the score
    final updatedMatch = await service.postHoleScore(playerId, currentHole, match.id, score);

    //Then update the local match
    match = updatedMatch;
    
    notifyListeners();   

  }

  String getPlayerName(int index){
    return match.players[index].firstName;
  }

  int getGrossScore(int index){
    return match.rounds[index].HoleScores[currentHole].score;
  }

  int getNetScore(int index){
    return match.rounds[index].HoleScores[currentHole].net;
  }

  int getStrokesGiven(int index){
    return match.rounds[index].HoleScores[currentHole].strokes;
  }

  dynamic getPlayerCurrentWinnings(int playerId, holeId){
    //Total to be returned
    dynamic total = 0;
    //Find all elements given a player and hole id, convert to list and for each element in that list, get the sum
    match.gamePlayerPoints.where((element) => element.playerId == playerId && element.holeNumber! <= holeId).toList().forEach((element) => total += element.value);
    //Return the total
    return total;
  }
}