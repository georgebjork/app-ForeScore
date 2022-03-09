import '../Utils/Stat.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PieChartStats extends StatefulWidget {
  //Hold all stats
  //Example Stat has num fairways hit, color and title
  List<Stat> stats = [];
  PieChartStats({Key? key, required this.stats}) : super(key: key);

  PieChartStatsState createState() => PieChartStatsState();
}

class PieChartStatsState extends State<PieChartStats> {

  //This will be for the chart
  List<charts.Series<Stat, String>> chartData = [];


  void getData(){
    chartData.add(charts.Series(
      id: 'Stats',
      colorFn: (Stat s, _) => charts.ColorUtil.fromDartColor(s.color),
      data: widget.stats,
      domainFn: (Stat s, _) => s.type,
      measureFn: (Stat s, _) => s.number,
      displayName: 'stats',
      labelAccessorFn: (Stat s, _) => s.type,
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
