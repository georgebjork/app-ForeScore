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
                //Hole
                const DataColumn(label: Center( child: Text('Hole'))),
                //Par
                const DataColumn(label: Center(child: Text('Par'))),
                //Players
              ] +  match.players.map((e) => DataColumn(label: Center(child: Text(e.firstName[0] + e.lastName[0])))).toList(), 
              rows: match.course.teeboxes[0].holes.map((e) => DataRow(cells: [
                //Hole Number
                DataCell(Center(child: Text(e.number.toString()))),
                //Par
                DataCell(Center(child: Text(e.par.toString(), style: TextStyle(fontWeight: FontWeight.bold)))),
                //This will display round scores 
              ] + match.rounds.map((r) { 
                //Return box for eagle or better
                if(r.HoleScores[e.number-1].strokesToPar < -1 && r.HoleScores[e.number-1].score != 0){
                  return DataCell(Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.purpleAccent.shade100, width: 4)
                    ),
                    child: Center(child: Text(r.HoleScores[e.number-1].score.toString()))));
                }

                //Return box for birdie
                else if(r.HoleScores[e.number-1].strokesToPar == -1){
                  return DataCell(Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.lightGreen.shade500, width: 4)
                    ),
                    child: Center(child: Text(r.HoleScores[e.number-1].score.toString()))));
                }
                //Return box for par
                else if(r.HoleScores[e.number-1].strokesToPar == 0){
                  return DataCell(Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.shade200,
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Center(child: Text(r.HoleScores[e.number-1].score.toString()))));
                }

                //Return for bogey
                else if(r.HoleScores[e.number-1].strokesToPar == 1){
                  return DataCell(Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.orange.shade200, width: 4)
                    ),
                    child: Center(child: Text(r.HoleScores[e.number-1].score.toString()))));
                }
                //Double bogey or worse
                else if(r.HoleScores[e.number-1].strokesToPar >= 2){
                  return DataCell(Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.grey.shade400, width: 4)
                    ),
                    child: Center(child: Text(r.HoleScores[e.number-1].score.toString()))));
                }
                //Base case
                else{
                  return DataCell(Center(child: Text(r.HoleScores[e.number-1].score.toString())));
                }

              }).toList())).toList()
            ),
          )          
      ]),
    );
  }
}