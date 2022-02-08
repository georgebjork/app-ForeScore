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

  List<ScoreStats> data = [];
  List<charts.Series<ScoreStats, String>> chartData = [];

  void getData(){
    data.add(ScoreStats('Eagles', widget.round.Stats.eagles,  charts.ColorUtil.fromDartColor(Colors.purple.shade100)));
    data.add(ScoreStats('Birdies', widget.round.Stats.birdies, charts.ColorUtil.fromDartColor(Colors.lightGreen.shade500)));
    data.add(ScoreStats('Par', widget.round.Stats.pars, charts.ColorUtil.fromDartColor(Colors.lightGreen.shade200)));
    data.add(ScoreStats('Bogeys', widget.round.Stats.bogeys, charts.ColorUtil.fromDartColor(Colors.orange.shade200)));
    data.add(ScoreStats('Doubles', widget.round.Stats.doubles, charts.ColorUtil.fromDartColor(Colors.grey.shade400)));
    data.add(ScoreStats('Triples', widget.round.Stats.triples, charts.ColorUtil.fromDartColor(Colors.grey.shade400)));
    data.add(ScoreStats('Worse', widget.round.Stats.worse, charts.ColorUtil.fromDartColor(Colors.grey.shade400)));

    chartData.add(charts.Series(
      id: 'Stats',
      colorFn: (ScoreStats s, _) => s.color,
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
     return charts.PieChart(chartData, animate: true);
   }
}