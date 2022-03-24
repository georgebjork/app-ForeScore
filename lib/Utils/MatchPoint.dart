import 'package:golf_app/Utils/Point.dart';

class MatchPoint{
  
  int id;
  int matchId;
  double value;
  String name;
  String description;
  int type;

  MatchPoint(this.id, this.matchId, this.value, this.name, this.description, this.type);

  MatchPoint.fromMatchPoint({
    required this.id,
    required this.matchId,
    required this.value,
    required this.name,
    required this.description,
    required this.type
  });

  factory MatchPoint.fromJson(dynamic res){
    return MatchPoint.fromMatchPoint(
      id: res['id'],
      matchId: res['matchId'],
      value: res['value'],
      name: res['name'],
      description: res['description'],
      type: res['type']
    );
  }
}