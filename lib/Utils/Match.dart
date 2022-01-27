import 'package:golf_app/Utils/Player.dart';

import 'Course.dart';
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
  Course course;
  TeeBox teeBox;
  //DateTime date;this.date
  List<MatchPlayer> players;
  List<Game> games;
  List<MatchPoint> matchPoints;
  List<GamePlayerPoint> gamePlayerPoints;
  List<GamePlayerResult> gamePlayerResult;
  List<MatchPlayerResult> matchPlayerResult;
  List<Round> rounds;

  Match(this.id, this.course, this.teeBox, this.players, this.games, this.matchPoints, this.gamePlayerPoints, this.gamePlayerResult, this.matchPlayerResult, this.rounds );

  Match.fromMatch({
    required this.id,
    required this.course,
    required this.teeBox,
    //required this.date,
    required this.players,
    required this.games,
    required this.matchPoints,
    required this.gamePlayerPoints,
    required this.gamePlayerResult,
    required this.matchPlayerResult,
    required this.rounds
  });

  factory Match.fromJson(dynamic res){
    List<dynamic> p = res['matchPlayers'];
    List<dynamic> g = res['games'];
    List<dynamic> mp = res['matchPoints'];
    List<dynamic> gpp = res['gamePlayerPoints'];
    List<dynamic> gpr = res['gamePlayerResults'];
    List<dynamic> mpr = res['matchPlayerResults'];
    List<dynamic> r = res['rounds'];
    return Match.fromMatch(
      id: res['id'],
      teeBox: TeeBox.fromJson(res['teeBox']),
      course: Course.fromJson(res['course']),
      //date: res['date'],
      players: p.map((e) => MatchPlayer.fromJson(e)).toList(),
      games: g.map((e) => Game.fromJson(e)).toList(),
      matchPoints: mp.map((e) => MatchPoint.fromJson(e)).toList(),
      gamePlayerPoints: gpp.map((e) => GamePlayerPoint.fromJson(e)).toList(),
      gamePlayerResult: gpr.map((e) => GamePlayerResult.fromJson(e)).toList(),
      matchPlayerResult: mpr.map((e) => MatchPlayerResult.fromJson(e)).toList(),
      rounds: r.map((e) => Round.fromJson(e)).toList()
    );
  }
}
