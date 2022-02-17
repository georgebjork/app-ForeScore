import 'package:flutter/material.dart';

import '../Utils/Round.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ScoreStats {
  String type;
  int number;
  charts.Color color;
  ScoreStats(this.type, this.number, this.color);
  
}

class PieChartStats extends StatefulWidget {

  final Round round;

  PieChartStats({Key? key, required this.round});

  PieChartStatsState createState() => PieChartStatsState();
}

class PieChartStatsState extends State<PieChartStats> {

  //This will hold all of our data
  List<ScoreStats> data = [];
  List<charts.Series<ScoreStats, String>> chartData = [];

  //Because a score of 0 is recorded as worse, we need to parse those out for an unfinished rounds
  int getWorse(){
    int total = 0;
    //We will go through hole by hole and calculate manually
    for(int i = 0; i < 18; i++){
      //If the score is greater than 0 and the strokes to par is greater than two, then we should record it because it is "worse"
      if(widget.round.HoleScores[i].score > 0 && widget.round.HoleScores[i].strokesToPar >= 2){
        total++;
      }
    }
    return total;
  }

  void getData(){
    //This will grab the stats from the round. 
    data.add(ScoreStats('Eagles', widget.round.Stats.eagles,  charts.ColorUtil.fromDartColor(Colors.purple.shade100)));
    data.add(ScoreStats('Birdies', widget.round.Stats.birdies, charts.ColorUtil.fromDartColor(Colors.lightGreen.shade600)));
    data.add(ScoreStats('Par', widget.round.Stats.pars, charts.ColorUtil.fromDartColor(Colors.lightGreen.shade200)));
    data.add(ScoreStats('Bogeys', widget.round.Stats.bogeys, charts.ColorUtil.fromDartColor(Colors.orange.shade200)));
    data.add(ScoreStats('Doubles', widget.round.Stats.doubles, charts.ColorUtil.fromDartColor(Colors.grey.shade400)));
    data.add(ScoreStats('Triples', widget.round.Stats.triples, charts.ColorUtil.fromDartColor(Colors.grey.shade400)));
    data.add(ScoreStats('Worse', getWorse(), charts.ColorUtil.fromDartColor(Colors.grey.shade400)));

    chartData.add(charts.Series(
      id: 'Stats',
      colorFn: (ScoreStats s, _) => s.color,
      data: data,
      domainFn: (ScoreStats s, _) => s.type,
      measureFn: (ScoreStats s, _) => s.number,
      displayName: 'stats',
      labelAccessorFn: (ScoreStats s, _) => s.type,
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }


   Widget build(BuildContext context) {
     return charts.PieChart(
       chartData, 
      //  defaultRenderer: charts.ArcRendererConfig(
      //   arcWidth: 5,
      //   arcRendererDecorators: [
      //     charts.ArcLabelDecorator(
      //       labelPosition: charts.ArcLabelPosition.inside
      //     )
      //   ]),
       animate: true,
      );
   }
}