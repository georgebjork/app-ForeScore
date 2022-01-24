import 'package:golf_app/Utils/Game.dart';
import 'package:golf_app/Utils/PointResult.dart';

class GamePlayerResult{
  
  int playerId;
  List<PointResult> pointResult;
  dynamic winnings;

  GamePlayerResult(this.playerId, this.pointResult, this.winnings);

  GamePlayerResult.fromGamePlayerResult({
    required this.playerId,
    required this.pointResult,
    required this.winnings
  });

  factory GamePlayerResult.fromJson(dynamic res){
    List<dynamic> pr = res['pointResults'];
    return GamePlayerResult.fromGamePlayerResult(
      playerId: res['playerId'],
      pointResult: pr.map((e) => PointResult.fromJson(e)).toList(),
      winnings: res['winnings']
    );
  }
}
