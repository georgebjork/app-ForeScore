import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Components/ScoreInputWidget.dart';
import 'package:golf_app/Utils/Providers/MatchProvider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../Components/NavWidget.dart';

class EnterScore extends StatefulWidget {

  EnterScoreState createState() => EnterScoreState();
}

class EnterScoreState extends State<EnterScore> {

  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: null,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Consumer<MatchProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Text(provider.match.course.name, style: Theme.of(context).primaryTextTheme.headline3),
                      const SizedBox(height: 5),
                      Text(provider.displayCurrentHole(), style: Theme.of(context).primaryTextTheme.headline2),
                      Text(provider.displayHoleDetails(), style: Theme.of(context).primaryTextTheme.headline4),
                      const SizedBox(height: 10),
                        
                          
                      Text('Scores', style: Theme.of(context).primaryTextTheme.headline3),
                      DisplayPlayerScores(),
                
                      const SizedBox(height: 10),
                
                      Text('Leaderboard', style: Theme.of(context).primaryTextTheme.headline3),
                      DisplayLeaderBoard(),
                      
                    ]
                  ),
                ),

                NavWidget(
                  btn1text: 'Prev',
                  btn1onPressed: () => provider.prevHole(),
            
                  btn2text: provider.currentHole == 17 ? 'Finish' : 'Next',
                  btn2onPressed: provider.currentHole == 17 ? () => Navigator.pushNamed(context, '/Home') : () => provider.nextHole(),
          
                  btn3text: 'Cancel',
                  btn3onPressed: () {}
                ),
                
                const SizedBox(height: 30)
              ],
            ),
          );
        }),
    );
  }
}

class DisplayPlayerScores extends StatefulWidget {

  DisplayPlayerScoresState createState() => DisplayPlayerScoresState();
}

class DisplayPlayerScoresState extends State<DisplayPlayerScores> {
  Widget build(context){
    return Container(
      child: Consumer<MatchProvider> (
        builder: (context, provider, child) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
            physics: ClampingScrollPhysics(),
            shrinkWrap: true, 
            itemCount: provider.match.players.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(provider.getPlayerName(index), style: Theme.of(context).primaryTextTheme.headline3),
                subtitle: Text("Strokes: " + provider.getStrokesGiven(index).toString()),
                trailing: Text(
                  "Gross: " + provider.getGrossScore(index).toString() + "   " +
                  "Net: " + provider.getNetScore(index).toString(),
                  style: Theme.of(context).primaryTextTheme.headline3),
                onTap: () => showBarModalBottomSheet(
                  context: context, 
                  expand: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ModalData(currentIndex: index)
                )
              );
            },
          );
        }
      ),
    );
  }
}

class DisplayLeaderBoard extends StatefulWidget {

  DisplayLeaderBoardState createState() => DisplayLeaderBoardState();
}

class DisplayLeaderBoardState extends State<DisplayLeaderBoard> {
  Widget build(context){
    return Container(
      child: Consumer<MatchProvider> (
        builder: (context, provider, child) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
            physics: ClampingScrollPhysics(),
            shrinkWrap: true, 
            itemCount: provider.match.players.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(provider.getPlayerName(index), style: Theme.of(context).primaryTextTheme.headline3),
                trailing: Text(
                  "Winnings: \$" + provider.getPlayerCurrentWinnings(provider.match.players[index].id, provider.currentHole+1).toString(),
                  style: Theme.of(context).primaryTextTheme.headline3
                ),
              );
            },
          );
        }
      ),
    );
  }
}


class ModalData extends StatefulWidget{

  final int currentIndex;

  ModalData({Key? key, required this.currentIndex}) : super(key: key);

  ModalDataState createState() => ModalDataState();

 
}

class ModalDataState extends State<ModalData> {
   Widget build(context){
     return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20, bottom: 10),
      child: Consumer<MatchProvider>(
        builder:(context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter Score", style: Theme.of(context).primaryTextTheme.headline2),

              //This will be to enter the gross score since we will always want that.
              Row(
                children: [
                  const SizedBox(height: 60,),
                  Text('Gross Score: ', style: Theme.of(context).primaryTextTheme.headline3),
                  
                  Expanded(child: Center()),
        
                  Container(width: 50, height: 30, child: ScoreInputWidget(
                    hintText: provider.match.rounds[widget.currentIndex].HoleScores[provider.currentHole].score.toString(),
                    playerId: provider.match.players[widget.currentIndex].id,
                  ))
                ],
              ),

              //This will be for all stats
              const SizedBox(height: 10),
              Text('Stats', style: Theme.of(context).primaryTextTheme.headline2),

              //Track Putts
              const SizedBox(height: 10),
              Text('Putts', style: Theme.of(context).primaryTextTheme.headline3),

              const SizedBox(height: 10),
              Row(
                children: const [
                  SizedBox(height: 10),
                  CheckMarkBox(isChecked: false),
                ],
              ),

              //Track fairways
              const SizedBox(height: 10),
              Text('Fairway', style: Theme.of(context).primaryTextTheme.headline3),

              const SizedBox(height: 10),
              Row(
                children: const [
                  SizedBox(height: 10),
                  CheckMarkBox(isChecked: false),
                ],
              ),


              //Track gir's 
              const SizedBox(height: 10),
              Text('GIR', style: Theme.of(context).primaryTextTheme.headline3),

              const SizedBox(height: 10),
              Row(
                children: const [
                  SizedBox(height: 10),
                  CheckMarkBox(isChecked: false),
                ],
              )
            ],
          );
        })
    );
   }
}