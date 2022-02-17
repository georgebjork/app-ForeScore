import 'package:flutter/material.dart';
import 'package:golf_app/Components/PieChartStats.dart';
import 'package:golf_app/Components/ScorecardMatchWidget.dart';
import 'package:golf_app/Utils/ViewMatchArgs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hexcolor/hexcolor.dart';




class ViewMatch extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    final args = ModalRoute.of(context)!.settings.arguments as ViewMatchArgs;

    String getPlayers(){
      String str = "";
      for(int i = 0; i < args.match.players.length; i++){
        str += args.match.players[i].firstName + " " + args.match.players[i].lastName[0] + ', ';
      }
      
      return str.substring(0, str.length-2);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  //Course name
                  Text(args.match.course.name, style: Theme.of(context).primaryTextTheme.headline2),
                  //Date
                  Text("Date: ", style: Theme.of(context).primaryTextTheme.headline3),
                  //Players
                  const SizedBox(height: 5),
                  Text("Players: " + getPlayers(), style: Theme.of(context).primaryTextTheme.headline3),
                  
                  //This will display the scorecard
                  const SizedBox(height: 10),
                  ScorecardMatchWidget(match: args.match),
        

                  const SizedBox(height: 30),
                  //This will display stats
                  Text('Stats', style: Theme.of(context).primaryTextTheme.headline2),

                  const SizedBox(height: 10),

                  CarouselSlider.builder(
                    options: CarouselOptions(height: 700.0, enlargeCenterPage: true,),
                    itemCount: args.match.rounds.length,
                    itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                      return Container(
                        decoration: BoxDecoration(color: HexColor("#e6e6e6"),  borderRadius: BorderRadius.circular(15.0),),
                        child: Column(
                          children: [
                              //Adds space from the top
                              const SizedBox(height: 20),
                              //Name of player
                              Text(args.match.players[index].firstName, style: Theme.of(context).primaryTextTheme.headline2),
                              //Pie Chart
                              SizedBox(height: 200, child: PieChartStats(round: args.match.rounds[index])),
                              //Legend
                              Text('Legend', style: Theme.of(context).primaryTextTheme.headline3),
                              const SizedBox(height: 10),

                              //This will give use the legend
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container( height: 20, width: 20, decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(7.0))),
                                  const SizedBox(width: 5),
                                  const Text('Eagle'),

                                  const SizedBox(width: 5),
                                  Container( height: 20, width: 20, decoration: BoxDecoration(color: Colors.lightGreen.shade600, borderRadius: BorderRadius.circular(7.0))),
                                  const SizedBox(width: 5),
                                  const Text('Birdie'),

                                  const SizedBox(width: 5),
                                  Container( height: 20, width: 20, decoration: BoxDecoration(color: Colors.lightGreen.shade200, borderRadius: BorderRadius.circular(7.0))),
                                  const SizedBox(width: 5),
                                  const Text('Par'),
                                ],
                              ),

                              const SizedBox(height: 5),

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container( height: 20, width: 20, decoration: BoxDecoration(color: Colors.orange.shade200, borderRadius: BorderRadius.circular(7.0))),
                                  const SizedBox(width: 5),
                                  const Text('Bogey'),

                                  const SizedBox(width: 5),
                                  Container( height: 20, width: 20, decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(7.0))),
                                  const SizedBox(width: 5),
                                  const Text('Double'),

                                  const SizedBox(width: 5), //
                                  Container( height: 20, width: 20, decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(7.0))),
                                  const SizedBox(width: 5),
                                  const Text('Triple+'),
                                ],
                              ),


                              //Seperate legend and round stats
                              const SizedBox(height: 10),
                              //Par 3/4/5 Scoring average
                              DataTable(
                                columnSpacing: 50,
                                dataTextStyle: Theme.of(context).primaryTextTheme.headline4,                                
                                columns: const [
                                  //Headers
                                  DataColumn(label: Center(child: Text("Par 3"))),
                                  DataColumn(label: Center(child: Text("Par 4"))),
                                  DataColumn(label: Center(child: Text("Par 5"))),
                                ],
                                rows: [
                                  //Rows
                                  DataRow(cells: [
                                    DataCell( Center(child: Text(args.match.rounds[index].Stats.par3ScoreAverage.toString()))),
                                    DataCell( Center(child: Text(args.match.rounds[index].Stats.par4ScoreAverage.toString()))),
                                    DataCell( Center(child: Text(args.match.rounds[index].Stats.par5ScoreAverage.toString())))

                                  ])
                                ],
                              ),

                              //Putts Greens Fairways
                              DataTable(
                                columnSpacing: 40,
                                dataTextStyle: Theme.of(context).primaryTextTheme.headline4,                                
                                columns: const [
                                  //Headers
                                  DataColumn(label: Center(child: Text("Putts"))),
                                  DataColumn(label: Center(child: Text("Greens"))),
                                  DataColumn(label: Center(child: Text("Fairways"))),
                                ],
                                rows: const [
                                  //Rows
                                  DataRow(cells: [
                                    DataCell( Center(child: Text('0'))),
                                    DataCell( Center(child: Text('0'))),
                                    DataCell( Center(child: Text('0')))

                                  ])
                                ],
                              ),
                          ],
                        ),
                      );
                    }
                  ),


                  

                  SizedBox(height: 30,),
                ]
              )
            ),
           

          ]
        ),
      ),
    );
  }
} 


// ListView.builder(
                  //   physics: ClampingScrollPhysics(),
                  //    shrinkWrap: true, 
                  //   itemCount: args.match.rounds.length,
                    
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return Card(
                  //       child: ExpansionTile(
                  //         title: Text(args.match.players[index].name.toString()),
                  //         children: [
                  //           Container(height: 200, width: 200, child: PieChartStats(round: args.match.rounds[index])),
                  //         ],
                  //       ),
                  //     );
                  //   }  
                  // ),