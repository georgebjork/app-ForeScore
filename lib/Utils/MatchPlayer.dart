
import 'package:golf_app/Utils/Player.dart';

class MatchPlayer extends Player {
  
  int courseHandicap;

  MatchPlayer(int id, String firstName, String lastName, String name, int handicap, this.courseHandicap) : super(id, firstName, lastName, name, handicap);

}