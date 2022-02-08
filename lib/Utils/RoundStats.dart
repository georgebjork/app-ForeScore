class RoundStats {
  int roundId;  
  int eagles;  
  int birdies;        
  int pars;
  int bogeys;
  int doubles;
  int triples;
  int worse;

  RoundStats(
    this.roundId,
    this.eagles,
    this.birdies,
    this.pars,
    this.bogeys,
    this.doubles,
    this.triples,
    this.worse,
  );

    RoundStats.fromRoundStats({
    required this.roundId,
    required this.eagles,
    required this.birdies,
    required this.pars,
    required this.bogeys,
    required this.doubles,
    required this.triples,
    required this.worse,
  });


  factory RoundStats.fromJson(dynamic res){
    return RoundStats.fromRoundStats(
      roundId: res['roundId'],
      eagles: res['eagles'],
      birdies: res['birdies'],
      pars: res['pars'],
      bogeys: res['bogeys'],
      doubles: res['doubles'],
      triples: res['triples'],
      worse: res['worse']
    );
  }



  
}
