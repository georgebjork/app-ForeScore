import '../Utils/Round.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ScoreStats {
  String type;
  int number;
  ScoreStats(this.type, this.number);
}

class PieChartStats extends StatefulWidget {

  final Round round;

  PieChartStats({Key? key, required this.round});

  PieChartStatsState createState() => PieChartStatsState();
}

class PieChartStatsState extends State<PieChartStats> {

  List<ScoreStats> data = [];
  List<charts.Series<ScoreStats, String>> chartData = [];

  void getData(){
    data.add(ScoreStats('Eagles', widget.round.Stats.eagles));
    data.add(ScoreStats('Birdies', widget.round.Stats.birdies));
    data.add(ScoreStats('Par', widget.round.Stats.pars));
    data.add(ScoreStats('Bogeys', widget.round.Stats.bogeys));
    data.add(ScoreStats('Doubles', widget.round.Stats.doubles));
    data.add(ScoreStats('Triples', widget.round.Stats.triples));
    data.add(ScoreStats('Worse', widget.round.Stats.worse));

    chartData.add(charts.Series(
      id: 'Stats',
      colorFn: (_,__) =>charts.MaterialPalette.green.shadeDefault,
      data: data,
      domainFn: (ScoreStats s, _) => s.type,
      measureFn: (ScoreStats s, _) => s.number,
      displayName: 'stats'
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }


   Widget build(BuildContext context) {
     return charts.PieChart(chartData, animate: true,);
   }
}