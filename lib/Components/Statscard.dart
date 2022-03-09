
import 'package:flutter/material.dart';
import 'package:golf_app/Components/PieChartStatsScoring.dart';

import '../Utils/Round.dart';

class Statscard extends StatelessWidget {

  final Widget? chart;
  final Color? color;
  final String title;
  List<Widget> legend = [];

  Statscard({
     Key? key,
     required this.chart,
     required this.color,
     required this.title,
     required this.legend,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 125, width: 125,child: chart),
          
          Expanded(
            flex: 5, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: legend           
                  ),
                ),
              ],
            )
          )
        ]
      )
    );
  }
}


class Legend extends StatelessWidget {

  final Color color;
  final String name;

  const Legend({Key? key, required this.color, required this.name}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0, left: 5.0),
        child: Row(  
          mainAxisSize: MainAxisSize.min,
          children: [
            Container( height: 15, width: 15, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5.0))),
            const SizedBox(width: 5),
            Text(name, style: const TextStyle(fontSize: 10)), 

          ],
        ),
      ),
    );
  }

}