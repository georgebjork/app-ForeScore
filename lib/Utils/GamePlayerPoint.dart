class GamePlayerPoint{
  
  int gameId;
  int pointId;
  int playerId;
  int ?holeNumber;
  dynamic value;
  

  GamePlayerPoint(this.gameId, this.holeNumber, this.playerId, this.pointId, this.value);

  GamePlayerPoint.fromGamePlayerPoint({
    required this.gameId,
    required this.pointId,
    required this.holeNumber,
    required this.playerId,
    required this.value
  });

  factory GamePlayerPoint.fromJson(dynamic res){
    return GamePlayerPoint.fromGamePlayerPoint(
      gameId: res['gameId'],
      pointId: res['pointId'],
      holeNumber: res['holeNumber'],
      playerId: res['playerId'],
      value: res['value']
    );
  }
}