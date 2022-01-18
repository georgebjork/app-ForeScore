
import 'package:flutter/cupertino.dart';
import 'package:golf_app/Utils/constants.dart';
import 'dart:convert';

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
  Future<List<Player>> getFriends() async {

    //Player list
    List<Player> f = [];

    //Run stored procedure to get friends
    final res = await supabase
      .from('users')
      .select('*')
      .execute();
    
    //Get the body from the data
    List<dynamic> body = res.data;
    //Map the players into the f list
    f = body.map((dynamic c) => Player.fromJson(c)).toList();
    friends = f;
    friends.removeWhere((element) => element.uuid == uuid);


    //Return list
    return f;
  }

}