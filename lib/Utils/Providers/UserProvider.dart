import 'dart:core';
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
  Future<void> getFriends() async {
    if(friends.isEmpty){
      friends = await service.getFriends();
    }
    
  }

}