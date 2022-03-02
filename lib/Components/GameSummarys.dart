import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utils/Player.dart';
import '../Utils/Match.dart';
import '../Utils/Providers/ThemeProvider.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: match.players.map((e) { 

              int count = 0;

              for(int i = 0; i < match.gamePlayerPoints.length; i++){
                //We want to check all skins points
                if(match.gamePlayerPoints[i].gameId == 3 && match.gamePlayerPoints[i].playerId == e.id && match.gamePlayerPoints[i].pointId != 0){
                  count++;
                }
              }
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: displayPlayerSkins(e, count, context))
              );

            }).toList()
          ),
        ],
      ),
    );
  }
}