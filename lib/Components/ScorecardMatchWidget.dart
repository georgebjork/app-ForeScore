import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/Round.dart';
import '../Utils/Match.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ScorecardMatchWidget extends StatelessWidget {

  final Match match;

  const ScorecardMatchWidget({
    Key? key, 
    required this.match
  }) : super(key: key);

  ScoreCardSourceData getSourceData() {
    return ScoreCardSourceData(match: match);
  }
  
  Widget build(BuildContext context){
    return Container(
      child: SfDataGrid(
        horizontalScrollPhysics: BouncingScrollPhysics(),
        verticalScrollPhysics: BouncingScrollPhysics(),
        source: getSourceData(), 
        columns: [
          GridColumn(
            columnName: 'Hole',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: const Text(
                'Hole',
                overflow: TextOverflow.ellipsis,
              )
            )
          ),
          GridColumn(
            columnName: 'Par',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: const Text(
                'Par',
                overflow: TextOverflow.ellipsis,
              )
            )
          ),
        ] + match.players.map((e) => GridColumn(
          columnName: e.id.toString(), 
          label: Container( 
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: Text(e.firstName, overflow: TextOverflow.ellipsis),
          )
        )).toList(),
      ) 
    );
  }
}

class ScoreCardSourceData extends DataGridSource{
  List<DataGridRow> dataGridRows = [];

  ScoreCardSourceData({required Match match}) {
    dataGridRows = match.course.teeboxes[0].holes.map((e) => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'Hole', value: e.number),
        DataGridCell<int>(columnName: 'Par', value: e.par)
      ] + match.rounds.map((r) => DataGridCell(columnName: r.PlayerId.toString(), value: r.HoleScores[e.number-1].score)).toList()
    )).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

/*
Column(
              children: [
                DataTable(
                  showBottomBorder: true,
                  headingRowHeight: 40,
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade300),
                  columns: [
                    //Hole
                    const DataColumn(label: Center( child: Text('Hole'))),
                    //Par
                    const DataColumn(label: Center(child: Text('Par'))),
                    //Players
                  ] +  match.players.map((e) => DataColumn(label: Container(width: 30, child: Center(child: Text(e.firstName[0] + e.lastName[0]))))).toList(), 
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
                //This will display totals
                DataTable(
                  showBottomBorder: true,
                  headingRowHeight: 40,
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade300),
                  columns: [
                    //Hole
                    DataColumn(label: Center( child: Text('Score'))),
                    //Par
                    DataColumn(label: Center(child: Text(match.course.teeboxes[0].par.toString()))),
                    //Players
                  ] +  match.rounds.map((e) => DataColumn(label: Container(width: 30, child: Center(child: Text(e.Score.toString()))))).toList(), 
                  rows: [],
                )
              ],
            ),

*/