class MatchPlayerResult {

  int playerId;
  dynamic winnings;

  MatchPlayerResult(this.playerId, this.winnings);

  MatchPlayerResult.fromMatchPlayerResult({
    required this.playerId,
    required this.winnings
  });

  factory MatchPlayerResult.fromJson(dynamic res){
    return MatchPlayerResult.fromMatchPlayerResult(
      playerId: res['playerId'],
      winnings: res['winnings']
    );
  }
}