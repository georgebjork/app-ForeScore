// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'Hole.dart';
import 'HoleScore.dart';
import 'RoundStats.dart';

class Round {
  int? id;
  int? Year;
  int PlayerId;
  String? PlayerName;
  int CourseId;
  String? CourseName;
  int TeeBoxId;
  String? TeeBoxName;
  int Yardage;
  int YardageOut;
  int YardageIn;
  int Slope;
  double Rating;
  //DateTime Date;
  int Handicap;
  int Score;
  int ScoreOut;
  int ScoreIn;
  int Par;
  int ParOut;
  int ParIn;
  int Net;
  int NetOut;
  int NetIn;
  bool FinishedFront;
  bool FinishedBack;
  bool FinishedRound;
  List<HoleScore> HoleScores;
  List<HoleScore> FrontHoleScores;
  List<HoleScore> BackHoleScores;
  List<Hole> Holes;
  RoundStats Stats;

  Round(
    this.id,
    this.Year,
    this.PlayerId,
    this.PlayerName,
    this.CourseId,
    this.CourseName,
    this.TeeBoxId,
    this.TeeBoxName,
    this.Yardage,
    this.YardageOut,
    this.YardageIn,
    this.Slope,
    this.Rating,
    this.Handicap,
    this.Score,
    this.ScoreOut,
    this.ScoreIn,
    this.Par,
    this.ParOut,
    this.ParIn,
    this.Net,
    this.NetOut,
    this.NetIn,
    this.FinishedFront,
    this.FinishedBack,
    this.FinishedRound,
    this.HoleScores,
    this.FrontHoleScores,
    this.BackHoleScores,
    this.Holes,
    this.Stats
  );

  Round.fromRound({
    required this.id,
    required this.Year,
    required this.PlayerId,
    required this.PlayerName,
    required this.CourseId,
    required this.CourseName,
    required this.TeeBoxId,
    required this.TeeBoxName,
    required this.Yardage,
    required this.YardageOut,
    required this.YardageIn,
    required this.Slope,
    required this.Rating,
    required this.Handicap,
    required this.Score,
    required this.ScoreOut,
    required this.ScoreIn,
    required this.Par,
    required this.ParOut,
    required this.ParIn,
    required this.Net,
    required this.NetOut,
    required this.NetIn,
    required this.FinishedFront,
    required this.FinishedBack,
    required this.FinishedRound,
    required this.HoleScores,
    required this.BackHoleScores,
    required this.FrontHoleScores,
    required this.Holes,
    required this.Stats
  });

  factory Round.fromJson(dynamic res) {
    List<dynamic> hs = res['holeScores'];
    List<dynamic> fhs = res['frontHoleScores'];
    List<dynamic> bhs = res['backHoleScores'];
    List<dynamic> h = res['holes'];

    return Round.fromRound(
      id: res['id'],
      Year: res['year'],
      PlayerId: res['playerId'],
      PlayerName:  res['playerName'],
      CourseId: res['courseId'], 
      CourseName: res['courseName'],
      TeeBoxId: res['teeBoxId'],
      TeeBoxName: res['teeBoxName'],
      Yardage: res['yardage'],
      YardageOut: res['yardageOut'],
      YardageIn: res['yardageIn'],
      Slope: res['slope'],
      Rating: res['rating'],
      Handicap: res['handicap'],
      Score: res['score'],
      ScoreOut: res['scoreOut'],
      ScoreIn: res['scoreIn'],
      Par: res['par'],
      ParIn: res['parIn'],
      ParOut: res['parOut'],
      Net: res['net'],
      NetOut: res['netOut'],
      NetIn: res['netIn'],
      FinishedBack: res['finishedBack'],
      FinishedFront: res['finishedFront'],
      FinishedRound: res['finishedRound'],
      HoleScores: hs.map((e) => HoleScore.fromJson(e)).toList(),
      FrontHoleScores: fhs.map((e) => HoleScore.fromJson(e)).toList(),
      BackHoleScores: bhs.map((e) => HoleScore.fromJson(e)).toList(),
      Holes: h.map((e) => Hole.fromJson(e)).toList(),
      Stats: RoundStats.fromJson(res['stats'])
    );
  }
}
