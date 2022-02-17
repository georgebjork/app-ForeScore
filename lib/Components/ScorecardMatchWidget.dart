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
          //frozenPaneLineColor: Colors.transparent,
          frozenPaneElevation: null
        ),
        child: SfDataGrid(
          rowsPerPage: 18,
          shrinkWrapRows: true,
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

          tableSummaryRows: [
            GridTableSummaryRow(
              showSummaryInRow: false,
              columns: const [
                GridSummaryColumn(
                  columnName: 'Par',
                  name: 'sum',
                  summaryType: GridSummaryType.sum
                )
              ] + match.players.map((e) => GridSummaryColumn(
                columnName: e.id.toString(), 
                name: 'sum',
                summaryType: GridSummaryType.sum
              )).toList(),
              position: GridTableSummaryRowPosition.bottom
            )
          ],
          
        ),
      ) 
    );
  }
}

class ScoreCardSourceData extends DataGridSource{
  List<DataGridRow> dataGridRows = [];
  BuildContext context;
  Match match;
  

  //This will create all of the source data for the table
  ScoreCardSourceData({required this.match, required this.context}) {
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
        //We give the value are combined number. First digit being the score and other digits being the strokes to par
        return DataGridCell(columnName: r.PlayerId.toString(), value: int.parse(str));
      }).toList()
    )).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;




  //This builds each row in the table
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
        //Build rows for hole and par
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

  /*

    BELOW WILL BUILD THE SUMMARY VIEW

  */

  //Custom implementation to summarize data

  @override
  String calculateSummaryValue(GridTableSummaryRow summaryRow, GridSummaryColumn? summaryColumn, RowColumnIndex rowColumnIndex) {

    List<int> getCellValues(GridSummaryColumn summaryColumn) {
      final List<int> values = <int>[];

      for (final DataGridRow row in rows) {
        
        final DataGridCell? cell = row.getCells().firstWhere(
            (DataGridCell element) =>
                element.columnName == summaryColumn.columnName);
        if (cell != null && cell.value != null) {
          values.add(cell.value);
        }
      }
      return values;
    }

    List<int> v = getCellValues(summaryColumn!);
    int sum = 0;

    //This will handle all sums of rounds
    if(summaryColumn.columnName != 'Par'){
      for(int i = 0; i < v.length; i++){
        //If number is less than 0, we need to remove the negitive
        if(v[i] < 0){
          sum += v[i]~/-10;
        } //Else divide by 10
        else{
          sum += v[i]~/10;
        }
      }
    } 
    else if(summaryColumn.columnName == 'Par'){
      for(int i = 0; i < v.length; i++){
        sum += v[i];
      }
    }
    
    return sum.toString();
  }



  //This will build the summary row and output the data 
  @override
  Widget? buildTableSummaryCellWidget(GridTableSummaryRow summaryRow, GridSummaryColumn? summaryColumn, RowColumnIndex rowColumnIndex, String summaryValue) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15.0),
      child: Text(summaryValue, style: Theme.of(context).primaryTextTheme.headline3),
    );
  }


}
