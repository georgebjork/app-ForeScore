import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Components/CustomNavButton.dart';
import 'package:golf_app/Components/ScoreInputWidget.dart';
import 'package:golf_app/Pages/RoundSummary.dart';
import 'package:golf_app/Utils/Providers/MatchProvider.dart';
import 'package:golf_app/Utils/all.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Utils/Match.dart';
import '../Components/NavWidget.dart';
import 'ViewMatch.dart';

class EnterScore extends StatefulWidget {

  Match match;

  EnterScore({Key? key, required this.match}) : super(key: key);

  @override
  EnterScoreState createState() => EnterScoreState();
}

class EnterScoreState extends State<EnterScore> {

  //This function will be called when the navigator pops and we need to update the state of the match
  void updateMatch(Match m){
    setState(() {
      widget.match = m;
    });
  }

  void nextPage() async {
    final updatedMatch = await Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: EnterScore(match: widget.match)));
    updateMatch(updatedMatch);
  }

  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: null,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                physics: BouncingScrollPhysics(),
                children: [
                  Text(widget.match.course.name, style: Theme.of(context).primaryTextTheme.headline3),
                  const SizedBox(height: 5),
                  Text(widget.match.displayCurrentHole(), style: Theme.of(context).primaryTextTheme.headline2),
                  Text(widget.match.displayHoleDetails(), style: Theme.of(context).primaryTextTheme.headline4),

                  //This will pull up the scorecard
                  CustomButton(text: 'View scorecard', width: double.infinity, color: context.read<ThemeProvider>().getRed(), onPressed: () {
                      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop,  duration: const Duration(milliseconds: 500), child: ViewMatch(match: widget.match)));
                  }),

                  const SizedBox(height: 10),
                    
                      
                  Text('Scores', style: Theme.of(context).primaryTextTheme.headline3),
                  DisplayPlayerScores(
                    onMatchChanged: (value) {
                      widget.match = value;
                      print('display player scores');
                      setState(() {});
                    },
                    match: widget.match,
                  ),
            
                  const SizedBox(height: 10),
            
                  Text('Leaderboard', style: Theme.of(context).primaryTextTheme.headline3),
                  DisplayLeaderBoard(
                    onMatchChanged: (value) {
                      widget.match = value;
                      setState(() {});
                    },
                    match: widget.match,
                  ),
                  
                ]
              ),
            ),

            NavWidget(
              btn1text: 'Prev',
              //When the prev button is pressed, we should set a new state of the match and decrease the current hole
              btn1onPressed: ()  => setState(() { widget.match.prevHole(); }),
        
              btn2text: widget.match.currentHole == 18 ? 'Finish' : 'Next',
              //When the prev button is pressed, we should set a new state of the match and increase the current hole
              //If the hole number is 18, then move to a match summary
              btn2onPressed: widget.match.currentHole == 18 ? 
                () => Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: RoundSummary(widget.match))) 
                : () => setState(() { widget.match.nextHole(); }),
      
              btn3text: 'Cancel',
              //No implementation yet 
              btn3onPressed: () {}
            ),
            
            const SizedBox(height: 30)
          ],
        ),
      )
    );
  }
}

class DisplayPlayerScores extends StatefulWidget {

  final ValueChanged<Match> onMatchChanged;
  Match match;

  DisplayPlayerScores({Key? key, required this.match, required this.onMatchChanged}) : super(key: key);

  DisplayPlayerScoresState createState() => DisplayPlayerScoresState();
}

class DisplayPlayerScoresState extends State<DisplayPlayerScores> {
  Widget build(context){
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
        ),
        physics: ClampingScrollPhysics(),
        shrinkWrap: true, 
        itemCount: widget.match.players.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(widget.match.getPlayerName(index), style: Theme.of(context).primaryTextTheme.headline3),
            subtitle: Text("Strokes: " + widget.match.getStrokesGiven(index).toString(), style: const TextStyle(fontSize: 10),),
            trailing: Text(
              "Gross: " + widget.match.getGrossScore(index).toString() + "   " +
              "Net: " + widget.match.getNetScore(index).toString(),
              style: Theme.of(context).primaryTextTheme.headline3),
            onTap: () => showBarModalBottomSheet(
              context: context, 
              expand: true,
              backgroundColor: Colors.transparent,
              builder: (context) => ModalData(
                currentIndex: index, 
                match: widget.match,
                onMatchChanged: (value) {
                  print('Display player score widget');
                  widget.match = value;
                  widget.onMatchChanged(widget.match);
                },
              )
            )
          );
        },
      )
    );
  }
}

class DisplayLeaderBoard extends StatefulWidget {

  final ValueChanged<Match> onMatchChanged;
  Match match;

  DisplayLeaderBoard({Key? key, required this.match, required this.onMatchChanged}) : super(key: key);

  DisplayLeaderBoardState createState() => DisplayLeaderBoardState();
}

class DisplayLeaderBoardState extends State<DisplayLeaderBoard> {
  Widget build(context){
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
        ),
        physics: ClampingScrollPhysics(),
        shrinkWrap: true, 
        itemCount: widget.match.players.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(widget.match.getPlayerName(index), style: Theme.of(context).primaryTextTheme.headline3),
            trailing: Text(
              "Winnings: \$" + widget.match.getPlayerCurrentWinnings(widget.match.players[index].id, widget.match.currentHole).toString(),
              style: Theme.of(context).primaryTextTheme.headline3
            ),
          );
        },
      )
    );
  }
}


class ModalData extends StatefulWidget{

  final ValueChanged<Match> onMatchChanged;
  final int currentIndex;
  Match match;

  ModalData({Key? key, required this.currentIndex, required this.match, required this.onMatchChanged}) : super(key: key);

  ModalDataState createState() => ModalDataState();

 
}

class ModalDataState extends State<ModalData> {
   Widget build(context){
     return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Enter Score", style: Theme.of(context).primaryTextTheme.headline2),

          //This will be to enter the gross score since we will always want that.
          Row(
            children: [
              const SizedBox(height: 60,),
              Text('Gross Score: ', style: Theme.of(context).primaryTextTheme.headline3),
              
              const Expanded(child: Center()),
    
              Container(width: 50, height: 30, child: ScoreInputWidget(
                onMatchChanged: (value) {
                  print('Model Widget');
                  widget.match = value;
                  widget.onMatchChanged(value);
                },
                match: widget.match,
                hintText: widget.match.rounds[widget.currentIndex].HoleScores[widget.match.currentHole-1].score.toString(),
                playerId: widget.match.players[widget.currentIndex].id,
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
      )
    );
   }
}