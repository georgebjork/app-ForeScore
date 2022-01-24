
import 'Point.dart';

class Game {

  int id;
  String name;
  List<Point> points;

  Game(this.id, this.name, this.points);

  Game.fromGame({
    required this.id,
    required this.name,
    required this.points
  });

  factory Game.fromJson(dynamic res){
    List<dynamic> p = res['points'];
    return Game.fromGame(
      id: res['id'],
      name: res['name'],
      points: p.map((e) => Point.fromJson(e)).toList(),
    );
  }
}