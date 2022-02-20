
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Utils/Round.dart';
import 'package:provider/provider.dart';
import '../Utils/Match.dart';
import '../Utils/Player.dart';
import '../Utils/Point.dart';
import '../Utils/Providers/ThemeProvider.dart';

class RoundSummary extends StatelessWidget {

  Match match;

  RoundSummary(this.match);

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

            SizedBox(height: 10),
            
            //const Divider(color: Colors.black, thickness: 3),

            SizedBox(height: 10),

            DisplaySkins(match),
          ],
        ),
      ),  
     
    );
  }
}

class DisplaySkins extends StatelessWidget {
  Match match;

  DisplaySkins(this.match);

  //This will hold a running total of the most skins
  int mostSkins = 0;

  displayPlayerSkins(Player p, int numSkins, BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    //If the most skins is overruled, then we will set it to the new highest
    if(numSkins > mostSkins){
      mostSkins = numSkins;
    }
    return Container(
      //padding: const EdgeInsets.all(10),
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
                    offset: Offset(0, 3), // changes position of shadow
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

              int pointsIndex =  match.games.indexWhere((element) => element.name == 'Skins');
              int count = 0;
              List<Point> points = match.games[pointsIndex].points;

              for(int i = 0; i < match.gamePlayerPoints.length; i++){
                //We want to check all skins points
                if(match.gamePlayerPoints[i].gameId == 3 && match.gamePlayerPoints[i].playerId == e.id && match.gamePlayerPoints[i].pointId != 0){
                  count++;
                }
              }

              return Expanded(child: Padding(
                padding: EdgeInsets.all(5.0),
                child: displayPlayerSkins(e, count, context)
              ));

            }).toList()
          ),

          // Row(
          //   children: match.players.map((e) {
          //     int pointsIndex =  match.games.indexWhere((element) => element.name == 'Skins');
          //     int count = 0;
          //     List<Point> points = match.games[pointsIndex].points;

          //     for(int i = 0; i < match.gamePlayerPoints.length; i++){
          //       //We want to check all skins points
          //       if(match.gamePlayerPoints[i].gameId == 3 && match.gamePlayerPoints[i].playerId == e.id && match.gamePlayerPoints[i].pointId != 0){
          //         count++;
          //       }
          //     }

          //     return Expanded(child: Container(
          //       padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.grey, width: 4)
          //       ),
          //      child: Center(child: Text(count.toString(), style: Theme.of(context).primaryTextTheme.headline2,  overflow: TextOverflow.ellipsis))
          //     ));

          //   }).toList()
          // ),


        ],
      ),
    );
  }

}