
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'package:golf_app/Utils/Round.dart';

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
    //This switch statement will display the game based on the name of the game
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
            
            //const Divider(color: Colors.black, thickness: 3),

            const SizedBox(height: 10),

            //Display the game summarys 
            Expanded(
              child: ListView(
                children: match.games.map((e) => displayGameSummary(e)).toList()
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

class DisplaySkins extends StatelessWidget {
  Match match;

  DisplaySkins({
    Key? key,
    required this.match,
  }) : super(key: key);

  //This will hold a running total of the most skins
  int mostSkins = 0;

  displayPlayerSkins(Player p, int numSkins, BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    //If the most skins is overruled, then we will set it to the new highest
    if(numSkins > mostSkins){
      mostSkins = numSkins;
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
        children: [
          //This will be the player name
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(child: Text(p.firstName, overflow: TextOverflow.ellipsis, style: Theme.of(context).primaryTextTheme.headline3)),
          ),
          //This will be the skins 
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: numSkins == mostSkins && mostSkins != 0 ? themeProvider.getGreen() : Colors.grey,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          
            child: Center(child: Text(numSkins.toString(), style: Theme.of(context).primaryTextTheme.headline2)),
          )

        ],
      ),
    );
  }

  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Skins', style: Theme.of(context).primaryTextTheme.headline2),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: match.players.map((e) { 

              int count = 0;

              for(int i = 0; i < match.gamePlayerPoints.length; i++){
                //We want to check all skins points
                if(match.gamePlayerPoints[i].gameId == 3 && match.gamePlayerPoints[i].playerId == e.id && match.gamePlayerPoints[i].pointId != 0){
                  count++;
                }
              }

              return Expanded(child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: displayPlayerSkins(e, count, context)
              ));

            }).toList()
          ),
        ],
      ),
    );
  }

}
