//This class will hold all of the needed information to create a match 
import 'package:golf_app/Utils/all.dart';

import 'Course.dart';
import 'TeeBox.dart';
import 'Player.dart';
import 'Game.dart';
import 'Match.dart';
class CreateMatch {
  //This will be the desired course for the match
  Course selectedCourse = Course(-1, "null");

  //This will be the selected teebox
  late TeeBox selectedTeeBox;

  //This will be the players;
  List<Player> players = [];

  //This will be the games to be played
  List<Game> games = [];

  //In order to initate the process of creating a match, we first need a course
  //CreateMatch({required this.selectedCourse});

  //This function will make an api request to create a match and return a populated match object
  Future<Match> createMatch() async {
    return await service.createMatch(selectedTeeBox.id, games, players);
  }

  //These functions will allow all variables to be set. All function names should be intuitive
  void setCourse(Course c){
    selectedCourse = c;
    print('Selected Course is: ${selectedCourse.name}');
  }

  void setTeeBox(TeeBox t){
    selectedTeeBox = t;
    print('Selected TeeBox is: ${selectedTeeBox.name}');
  }

  void addPlayer(Player p){
    players.add(p);
    print('Added Player: ${p.name}');
  }

  void setPlayer(List<Player> p){
    players = p;
    print('Updated Players to: $p');
  }

  void addGame(Game g){
    games.add(g);
    print('Added Game: ${g.name}');
  }

}