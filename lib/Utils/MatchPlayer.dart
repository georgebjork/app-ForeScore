
import 'package:golf_app/Utils/Player.dart';

class MatchPlayer extends Player {
  
  int courseHandicap;

  MatchPlayer(int id, String firstName, String lastName, String name, double handicap, this.courseHandicap) 
  : super(id, firstName, lastName, name, handicap);

  MatchPlayer.fromMatchPlayer({
    required this.courseHandicap,
    required id,
    required firstName,
    required lastName,
    required name,
    required handicap
  }) : super(id, firstName, lastName, name, handicap);


  factory MatchPlayer.fromJson(dynamic res){
    return MatchPlayer.fromMatchPlayer(
      courseHandicap: res['courseHandicap'],
      id: res['id'],
      name: res['name'],
      firstName: res['firstName'],
      lastName: res['lastName'],
      handicap: res['handicap']
    );
  }
}