import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/Round.dart';
import '../Utils/Match.dart';

class ScorecardMatchWidget extends StatelessWidget {

  final Match match;

  const ScorecardMatchWidget({
    Key? key, 
    required this.match
  }) : super(key: key);

  
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade300),
              columns: [
                const DataColumn(label: Text('Hole')),
                const DataColumn(label: Text('Par')),
              ] +  match.players.map((e) => DataColumn(label: Text(e.firstName[0] + e.lastName[0]))).toList(), 
              rows: match.course.teeboxes[0].holes.map((e) => DataRow(cells: [
                //Hole Number
                DataCell(Text(e.number.toString())),
                //Par
                DataCell(Text(e.par.toString())),
                //This will display round scores
              ] + match.rounds.map((r) => DataCell(Text(r.HoleScores[e.number-1].score.toString()))).toList())).toList()
            ),
          )          
      ]),
    );
  }
}