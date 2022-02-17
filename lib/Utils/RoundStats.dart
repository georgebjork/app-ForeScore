class RoundStats {
  int roundId;  
  int eagles;  
  int birdies;        
  int pars;
  int bogeys;
  int doubles;
  int triples;
  int worse;
  int par3ScoreToPar;
  int par4ScoreToPar;
  int par5ScoreToPar;
  int par3ScoreOnPar;
  int par4ScoreOnPar;
  int par5ScoreOnPar;
  dynamic par3ScoreAverage;
  dynamic par4ScoreAverage;
  dynamic par5ScoreAverage;

  RoundStats(
    this.roundId,
    this.eagles,
    this.birdies,
    this.pars,
    this.bogeys,
    this.doubles,
    this.triples,
    this.worse,
    this.par3ScoreAverage,
    this.par3ScoreOnPar,
    this.par3ScoreToPar,
    this.par4ScoreAverage,
    this.par4ScoreOnPar,
    this.par4ScoreToPar,
    this.par5ScoreAverage,
    this.par5ScoreOnPar,
    this.par5ScoreToPar
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
    required this.par3ScoreAverage,
    required this.par3ScoreOnPar,
    required this.par3ScoreToPar,
    required this.par4ScoreAverage,
    required this.par4ScoreOnPar,
    required this.par4ScoreToPar,
    required this.par5ScoreAverage,
    required this.par5ScoreOnPar,
    required this.par5ScoreToPar
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
      worse: res['worse'],
      par3ScoreAverage: res['par3ScoreAverage'],
      par4ScoreAverage: res['par4ScoreAverage'],
      par5ScoreAverage: res['par5ScoreAverage'],
      par3ScoreOnPar: res['par3ScoreOnPar'],
      par4ScoreOnPar: res['par4ScoreOnPar'],
      par5ScoreOnPar: res['par5ScoreOnPar'],
      par3ScoreToPar: res['par3ScoreToPar'],
      par4ScoreToPar: res['par4ScoreToPar'],
      par5ScoreToPar: res['par5ScoreToPar']
    );
  }



  
}
