import 'dart:io';

import 'package:flutter/material.dart';
import 'package:golf_app/Components/PieChartStats.dart';
import 'package:golf_app/Components/ScorecardMatchWidget.dart';
import 'package:golf_app/Utils/ViewMatchArgs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Utils/Match.dart';




class ViewMatch extends StatelessWidget {

  Match match;
  ViewMatch({required this.match});

  @override
  Widget build(BuildContext context){

    //final args = ModalRoute.of(context)!.settings.arguments as ViewMatchArgs;

    String getPlayers(){
      String str = "";
      for(int i = 0; i < match.players.length; i++){
        str += match.players[i].firstName + " " + match.players[i].lastName[0] + ', ';
      }
      
      return str.substring(0, str.length-2);
    }

    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(icon: Platform.isAndroid ? const Icon(Icons.arrow_back) : const Icon(Icons.arrow_back_ios_new), color: Colors.black, onPressed: () => Navigator.pop(context)),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Match id: ${match.id}', style: Theme.of(context).primaryTextTheme.headline3)
      ),
      body: Container(
        //padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  //Course name                    
                  Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(match.course.name, style: Theme.of(context).primaryTextTheme.headline2),
                        //Date
                        Text("Date: ", style: Theme.of(context).primaryTextTheme.headline3),
                        //Players
                        const SizedBox(height: 5),
                        Text("Players: " + getPlayers(), style: Theme.of(context).primaryTextTheme.headline3),
                      ],
                    ),
                  ),
                  
                  
                  //This will display the scorecard
                  const SizedBox(height: 10),
                  
                  ScorecardMatchWidget(match: match),
        

                  const SizedBox(height: 30),
                  //This will display stats
                  Container( padding:  const EdgeInsets.only(left: 20.0, right: 20.0), child: Text('Stats', style: Theme.of(context).primaryTextTheme.headline2)),

                  const SizedBox(height: 10),

                  CarouselSlider.builder(
                    options: CarouselOptions(height: 700.0, enlargeCenterPage: true,),
                    itemCount: match.rounds.length,
                    itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                      return Container(
                        decoration: BoxDecoration(color: HexColor("#e6e6e6"),  borderRadius: BorderRadius.circular(15.0),),
                        child: Column(
                          children: [
                              //Adds space from the top
                              const SizedBox(height: 20),
                              //Name of player
                              Text(match.players[index].firstName, style: Theme.of(context).primaryTextTheme.headline2),
                              //Pie Chart
                              SizedBox(height: 200, child: PieChartStats(round: match.rounds[index])),
                              //Legend
                              Text('Legend', style: Theme.of(context).primaryTextTheme.headline3),
                              const SizedBox(height: 10),

                              //This will give use the legend
                              SizedBox(
                                width: 225,
                                child: Wrap(
                                  children: [
                                    const SizedBox(width: 15),
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
                                    const SizedBox(width: 30),

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
                                    DataCell( Center(child: Text(match.rounds[index].Stats.par3ScoreAverage.toString()))),
                                    DataCell( Center(child: Text(match.rounds[index].Stats.par4ScoreAverage.toString()))),
                                    DataCell( Center(child: Text(match.rounds[index].Stats.par5ScoreAverage.toString())))

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
                  //   itemCount: match.rounds.length,
                    
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return Card(
                  //       child: ExpansionTile(
                  //         title: Text(match.players[index].name.toString()),
                  //         children: [
                  //           Container(height: 200, width: 200, child: PieChartStats(round: match.rounds[index])),
                  //         ],
                  //       ),
                  //     );
                  //   }  
                  // ),