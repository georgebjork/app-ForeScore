import 'package:golf_app/Utils/Player.dart';

import 'Game.dart';
import 'GamePlayerPoint.dart';
import 'GamePlayerResult.dart';
import 'MatchPlayer.dart';
import 'MatchPlayerResult.dart';
import 'MatchPoint.dart';
import 'Round.dart';
import 'TeeBox.dart';

class Match {
  int id;
  TeeBox teeBox;
  DateTime date;
  List<MatchPlayer> players;
  List<Game> games;
  List<MatchPoint> matchPoints;
  List<GamePlayerPoint> gamePlayerPoints;
  List<GamePlayerResult> gamePlayerResult;
  List<MatchPlayerResult> matchPlayerResult;
  List<Round> rounds;

  Match(this.id, this.teeBox, this.date, this.players, this.games, this.matchPoints, this.gamePlayerPoints, this.gamePlayerResult, this.matchPlayerResult, this.rounds);

  
}
