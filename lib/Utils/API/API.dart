import 'dart:convert';
import 'package:golf_app/Utils/Course.dart';
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

  Future<Match> addMatchPlayers(Match m, List<Player> players) async {
    Match match = m;
    
    for(int i = 0; i < players.length; i++){

      var payLoad = jsonEncode({
      'id' : players[i].id.toString()
      });

      var res = await post(Uri.parse(baseURL + "matches/" + m.id.toString() + "/player"), body: payLoad, headers: postHeaders);
    }

    return match;
  }


  Future<Match> createMatch(int teeboxId, List<int>gameIds, List<Player> players) async {
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
        return match;
      } 
      else{
        throw Exception("Error creating match");
      }
    });

    match = res;
    print("Match with id: ${match.id} created");
    return match;

  }


}