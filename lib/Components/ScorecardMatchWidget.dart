import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Components/ScoreDecoration.dart';

import '../Utils/Round.dart';
import '../Utils/Match.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ScorecardMatchWidget extends StatelessWidget {

  final Match match;

  const ScorecardMatchWidget({
    Key? key, 
    required this.match
  }) : super(key: key);

  ScoreCardSourceData getSourceData(BuildContext context) {
    return ScoreCardSourceData(match: match, context: context);
  }
  
  Widget build(BuildContext context){
    return Container(
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
          frozenPaneLineWidth: null,
          frozenPaneElevation: null
        ),
        child: SfDataGrid(
          horizontalScrollPhysics: BouncingScrollPhysics(),
          verticalScrollPhysics: BouncingScrollPhysics(),
          source: getSourceData(context), 
          frozenColumnsCount: 1,
          columns: [
            GridColumn(
              columnName: 'Hole',
              label: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: Text(
                  'Hole',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).primaryTextTheme.headline3),
                )
              ),
            GridColumn(
              columnName: 'Par',
              label: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: Text(
                  'Par',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).primaryTextTheme.headline3),
                )
              )
          ] + match.players.map((e) => GridColumn(
            columnName: e.id.toString(), 
            label: Container( 
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(e.firstName, overflow: TextOverflow.ellipsis, style: Theme.of(context).primaryTextTheme.headline3),
            )
          )).toList(),
        ),
      ) 
    );
  }
}

class ScoreCardSourceData extends DataGridSource{
  List<DataGridRow> dataGridRows = [];
  BuildContext context;

  ScoreCardSourceData({required Match match, required this.context}) {
    dataGridRows = match.course.teeboxes[0].holes.map((e) => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'Hole', value: e.number),
        DataGridCell<int>(columnName: 'Par', value: e.par)
      ] + match.rounds.map((r) {
        //Hold the score
        String str1 = r.HoleScores[e.number-1].score.toString();
        //Hold the strokesToPar
        String str2 = r.HoleScores[e.number-1].strokesToPar.toString();
        //Combine
        String str;
        //Because of the negitive, if we move the negitve to the front, then -31 % 10 == -1 effectivly giving us our -1 strokes from par again
        if(str2[0] == '-'){
          str = '-' + str1 +  str2.substring(1);
        } else{
          str = str1 + str2;
        }
        
        return DataGridCell(columnName: r.PlayerId.toString(), value: int.parse(str));
      }).toList()
    )).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {

        if(dataGridCell.columnName == 'Hole' || dataGridCell.columnName == 'Par') {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).primaryTextTheme.headline3
            )
          );
        }
        //Since our data is coming in as a combined number. Mod 10 will give strokes to par and divide by 10 will give the score
        else {
          if(dataGridCell.value < 0){
            //Divide by -10 to get postive number 
            return ScoreDecoration(score: (dataGridCell.value/-10).toInt(), strokesToPar: dataGridCell.value.remainder(10));
          } 
          else{
            return ScoreDecoration(score: (dataGridCell.value/10).toInt(), strokesToPar: dataGridCell.value%10);
          }
        } 
  
    }).toList());
  }
}
