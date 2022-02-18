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


  //********************************************//

    //MATCH CREATION METHODS

  //********************************************//

  Future<Match> createMatch(int teeboxId, List<Game>games, List<Player> players) async {
    Match match;

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
      //Once we get a response, check the status code for a 200 code
      if(response.statusCode == 200){
        //If we get a 200 take the response and extract just the body and convert into a match
        match = Match.fromJson(jsonDecode(response.body));
        //Now we should add the players and get a repsonse back from our function.
        var res = await addMatchPlayers(match, players);
        //Return the response
        return res;
      } 
      else{
        //Throw an error
        throw Exception("Error creating match");
      }
    }).then((response) async {
      //Once we get a response returned from the previous statment, check the status code for a 200 code
      if(response.statusCode == 200){
        //If we get a 200 take the response and extract just the body and convert into a match
        match = Match.fromJson(jsonDecode(response.body));
        //Get a response from our function
        var res = addMatchGames(match, games);
        //Return the response
        return res;
      } 
      else{
        throw Exception("Error creating match");
      }
    });

    match = Match.fromJson(jsonDecode(res.body));
    print("Match with id: ${match.id} created");
    return match;

  }


  Future<Response> addMatchPlayers(Match m, List<Player> players) async {
    //This will hold our response
    var res;
    
    for(int i = 0; i < players.length; i++){
      //This will hold the payload
      var payLoad = jsonEncode({  
      'id' : '${players[i].id}'
      });
      //Post request
      res = await post(Uri.parse(baseURL + "matches/${m.id}/player"), 
        body: payLoad, 
        headers: postHeaders
      ).then((response){
        if(response.statusCode == 200){
          //If response is 200 then return response
          return response;
        } 
        else{
          throw Exception("Error adding players to the match");
        }
      });
    }
    //Return res
    return res;
  }


  Future<Response> addMatchGames(Match m, List<Game> games) async {
    //This will hold the final response
    var res;

    for(int i = 0; i < games.length; i++){
      //Create payload
      var payLoad = jsonEncode({
        'id' : games[i].id.toString()
      });
      //Post request
      res = await post(Uri.parse(baseURL + "/matches/${m.id}/game"), 
        body: payLoad, 
        headers: postHeaders
      ).then((response){
        //If status code is 200 then return that response
        if(response.statusCode == 200){
          return response;
        } 
        else{
          throw Exception("Error adding players to the match");
        }
      });
    }
    //Return res
    return res;
  }


  //********************************************//

    //SCORING METHODS

  //********************************************//

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

  //********************************************//

    //GETTERS

  //********************************************//



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

}

  


  

