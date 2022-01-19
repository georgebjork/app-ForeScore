import 'dart:convert';
import 'Player.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class API{

  final String baseURL = "https://tgin-api.azurewebsites.net/api/";

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
}