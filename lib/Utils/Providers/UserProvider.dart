
import 'package:flutter/cupertino.dart';
import 'package:golf_app/Utils/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../Player.dart';

//this wil hold all necessary information about our user
class UserProvider extends ChangeNotifier{

  String firstName = "George";
  String lastName = "Bjork";
  final String uuid = supabase.auth.currentUser!.id;

  double handicap = 10.2;

  List<Player> friends = [];

  getFirstName() => firstName;
  getHandicap() => handicap;



  //This function will return the friends of the user and put them in the friends list
  Future<void> getFriends() async {

    //Run stored procedure to get friends
    String url = "https://tgin-api.azurewebsites.net/api/players";
    
    //Call the api
    var res = await get(Uri.parse(url));

    //Move raw data into a list
    List<dynamic> body = jsonDecode(res.body);

    //Map into friends list
    friends = body.map((dynamic c) => Player.fromJson(c)).toList();
  }

}