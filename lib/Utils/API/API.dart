import 'dart:convert';
import 'package:golf_app/Utils/Course.dart';
import 'package:golf_app/Utils/Game.dart';
import 'package:golf_app/Utils/TeeBox.dart';

import '../Player.dart';
import '../Match.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class API{

  final String baseURL = "https://tgin-api.azurewebsites.net/api/";

  final postHeaders = {
          "Accept": "application/json",
          "content-type": "application/json"
        };

  Future<List<Player>> getFriends() async {
    //Hold list of players
    List<Player> friends;

    //Get raw data
    var res = await get(Uri.parse(baseURL + "players"));

    //Move raw data into a list
    List<dynamic> body = jsonDecode(res.body);

    //Map into friends list
    friends = body.map((dynamic c) => Player.fromJson(c)).toList();

    //Return list
    return friends;
  }

  Future<List<TeeBox>> getCourseTeeBox(int courseId) async {
    List <TeeBox> teeboxs;

    var res = await get(Uri.parse(baseURL + "courses/$courseId"));

    dynamic body = jsonDecode(res.body);
    List<dynamic> bodyTeeBox = body['teeBoxes'];

    teeboxs = bodyTeeBox.map((e) => TeeBox.fromJson(e)).toList();

    return teeboxs;
  }

  Future<List<Course>> getFavoriteCourses() async {
    //A list of courses to return
    List<Course> courses;
    
    //Make a get request
    var res = await get(Uri.parse(baseURL + "courses"));

    //Put raw data into a list
    List<dynamic> body = jsonDecode(res.body);

    //Map all courses into the list we created
    courses = body.map((dynamic c) => Course.fromJson(c)).toList();

    //Return list
    return courses;
  }

  Future<Match> getMatch(int id) async {
    var res = await get(Uri.parse(baseURL + "matches/$id"));

    dynamic body = jsonDecode(res.body);

    Match match = Match.fromJson(body);

    return match;
  }

  Future<Match> addMatchGames(Match m, List<Game> games) async {
    Match match = m;
    var res;

    for(int i = 0; i < games.length; i++){
      var payLoad = jsonEncode({
        'id' : games[i].id.toString()
      });

      res = await post(Uri.parse(baseURL + "/matches/${match.id}/game"), body: payLoad, headers: postHeaders);
    }

    dynamic body = jsonDecode(res.body);
    match = Match.fromJson(body);

    return match;
  }

  Future<Match> addMatchPlayers(Match m, List<Player> players) async {
    Match match = m;
    var res;
    
    for(int i = 0; i < players.length; i++){

      var payLoad = jsonEncode({
      'id' : players[i].id.toString()
      });

      res = await post(Uri.parse(baseURL + "matches/" + m.id.toString() + "/player"), body: payLoad, headers: postHeaders);
      
    }

    dynamic body = jsonDecode(res.body);
    match = Match.fromJson(body);

    return match;
  }


  Future<Match> createMatch(int teeboxId, List<Game>games, List<Player> players) async {
    Match match;
    dynamic body;

    //Create the match
    var payLoad = jsonEncode({
      'id' : '$teeboxId'
    });
    
    var res = await post(Uri.parse(baseURL + "match"), body: payLoad,
      headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
    ).then((response) async {
      if(response.statusCode == 200){
        body = jsonDecode(response.body);

        match = Match.fromJson(body);

        match = await addMatchPlayers(match, players);
        match = await addMatchGames(match, games);
        return match;
      } 
      else{
        throw Exception("Error creating match");
      }
    });

    
    print("Match with id: ${res.id} created");
    return res;

  }

  Future<Match> postHoleScore(int playerId, int holeId, int matchId, int score) async {
    //https://tgin-api.azurewebsites.net/api/matches/{matchid}/players/{playerid}

    var payLoad = jsonEncode({
      'number' : '$holeId',
      'score' : '$score'
    });

    var res = await post(Uri.parse(baseURL + "matches/$matchId/players/$playerId"), body: payLoad,
      headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
    ).then((response) {
      if(response.statusCode == 200) {
        print("Score posted");

        var body = jsonDecode(response.body);

        Match match = Match.fromJson(body);

        return match;
      } 
      else{
        throw Exception("Error posting score");
      }
    });

    return res;
  }
}