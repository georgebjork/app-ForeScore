class HoleScore {
  int score;
  int net;
  int strokes;
  int strokesToPar;

  HoleScore(this.score, this.net, this.strokes, this.strokesToPar);

  HoleScore.fromHoleScore({
    required this.score,
    required this.net,
    required this.strokes,
    required this.strokesToPar
  });

  factory HoleScore.fromJson(dynamic res){
    return HoleScore.fromHoleScore(
      score: res['score'],
      net: res['net'],
      strokes: res['strokes'],
      strokesToPar: res['scoreToPar']
    );
  }
}