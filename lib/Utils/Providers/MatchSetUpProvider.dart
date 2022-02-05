
import 'package:flutter/cupertino.dart';
import 'package:golf_app/Utils/Game.dart';
import 'package:golf_app/Utils/Match.dart';
import 'package:golf_app/Utils/Player.dart';
import 'package:golf_app/Utils/TeeBox.dart';
import 'package:golf_app/Utils/all.dart';

import '../Course.dart';

class MatchSetUpProvider extends ChangeNotifier {

  List<Player> selectedPlayers = [];

  Course selectedCourse = Course(-1, "null");
  bool isCourseSelected = false;

  TeeBox selectedTeeBox = TeeBox(-1, -1, "null", -1, -1, -1, -1, -1);
  bool isTeeBoxSelected = false;

  List<Game> games = [Game(3, 'Skins'), Game(4, 'Nassau')];
  List<Game> selectedGames = []; 

  List<Course> favoriteCourses = [];


  Future<List<Course>> getFavoriteCourses() async {
    //get favorite courses from the api
    favoriteCourses = await service.getFavoriteCourses();
    return favoriteCourses;
  }

  void setCourse(Course c){
    selectedCourse = c;
    isCourseSelected = true;
  }

  void setTeeBox(TeeBox t){
    selectedTeeBox = t;
    isTeeBoxSelected = true;
  }

  void addPlayer(Player p){
    //first check if the player is in the list
    if(selectedPlayers.contains(p) == false) {
      //if not in the list, check to make sure we are not over the max size
      if(selectedPlayers.length == 4) {
        //if we are, remove the index 1 player since 0 is the user and 1 is the first player added
        selectedPlayers.removeAt(1);
      }
      // add the player
      selectedPlayers.add(p);
    }
  }

  void removePlayer(Player p){
    //check to make sure this player actually exists
    if(selectedPlayers.contains(p) == true) {
      selectedPlayers.removeWhere((element) => element == p);
    }
  }

  Future<Match> createMatch() async {

    Match m = await service.createMatch(selectedTeeBox.id, selectedGames, selectedPlayers);

    return m;
  }
}