

import 'package:flutter/material.dart';
import 'package:golf_app/Components/PieChartStatsScoring.dart';
import 'package:golf_app/Components/Statscard.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../Components/GameSummarys.dart';
import '../Components/CustomNavButton.dart';
import '../Utils/Game.dart';
import '../Utils/Match.dart';
import '../Utils/Player.dart';
import '../Utils/Point.dart';
import '../Utils/Providers/ThemeProvider.dart';

class RoundSummary extends StatelessWidget {

  Match match;

  RoundSummary(this.match);


  //This will take in a game and display it to the screen
  Widget displayGameSummary(Game game) {
    //This switch statement will display the game based on the name of the game. Classes imported from GameSummarys
    switch(game.name) {
      case 'Skins': return DisplaySkins(match: match);
      case 'Nasseau' : return Container();
    }
    return Container();
  }


  Widget build(BuildContext context){

    final themeProvider = context.read<ThemeProvider>();
    
    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(icon: Platform.isAndroid ? const Icon(Icons.arrow_back) : const Icon(Icons.arrow_back_ios_new), color: Colors.black, onPressed: () => Navigator.pop(context)),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        //padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(padding: const EdgeInsets.only(left: 20.0, right: 20.0), child: Text('Round Summary', style: Theme.of(context).primaryTextTheme.headline2)),

            const SizedBox(height: 10),
            
            const SizedBox(height: 10),

            //Display the game summarys 
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: match.games.map((e) => displayGameSummary(e)).toList()
                  ),

                  //Display Round Stats
                  Container(padding: const EdgeInsets.only(left: 20.0, right: 20.0), child: Text('Stats', style: Theme.of(context).primaryTextTheme.headline2)),
                  DisplayRoundStats(match: match)
                ],
              ),
            ),

            //Finish button sent to the bottom of the screen
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: CustomButton(
                onPressed: () => Navigator.pushNamed(context, '/Home'),
                width: double.infinity,
                text: 'Finish',
                color: HexColor("#A13333")
              ),
            ),
            const SizedBox(height: 30)

          ],
        ),
      ),  
     
    );
  }
}



class DisplayRoundStats extends StatelessWidget {
  Match match;

  DisplayRoundStats({
    Key? key,
    required this.match,
  }) : super(key: key);

  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView( 
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: match.players.map((e) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Statscard(chart: PieChartStatsScoring(round: match.rounds[0]), title: 'testing this', color: Colors.grey[350]),
        )).toList(),
      )
    );
  }
}
