
import 'package:flutter/material.dart';
import 'package:golf_app/Components/PieChartStatsScoring.dart';

import '../Utils/Round.dart';

class Statscard extends StatelessWidget {

  final Widget chart;
  final Color? color;
  final String title;
  Widget? body;

  Statscard({
     Key? key,
     required this.chart,
     required this.color,
     required this.title,
     this.body
  }) : super(key: key);

  /*
                      LAYOUT
    +--------------------------------------------+
    |                     |        TITLE         |
    |   GRAPH             | -------------------- |
    |                     |        LEGEND        |
    +--------------------------------------------+
  */

   @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 125, width: 125,child: chart),
          //SizedBox(height: 150, width: 150,child: PieChartStatsScoring(round: round)),
          Expanded(
            flex: 5, 
            child: Container(
              color: Colors.green, 
              child: const Center(child: Text('legend'))
            )
          )
        ]
      )
    );
  }
}