import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utils/Player.dart';
import '../Utils/Match.dart';
import '../Utils/Providers/ThemeProvider.dart';

class DisplaySkins extends StatefulWidget {
  Match match;

  DisplaySkins({
    Key? key,
    required this.match,
  }) : super(key: key);

  @override
  State<DisplaySkins> createState() => _DisplaySkinsState();
}

class _DisplaySkinsState extends State<DisplaySkins> {
  //This will hold a running total of the most skins
  int mostSkins = 0;

  void initState(){
    getMostSkins();
    super.initState();
    
  }

  void getMostSkins() {
    int count = 0;

    for(int i = 0; i < widget.match.players.length; i++){
       print('Calculating Player id: ${widget.match.players[i].id}');
      for(int j = 0; j < widget.match.gamePlayerPoints.length; j++){
        if(widget.match.gamePlayerPoints[j].gameId == 3 && widget.match.gamePlayerPoints[j].playerId == widget.match.players[i].id && widget.match.gamePlayerPoints[j].pointId != 0)
        {
          count++;
          //print(widget.match.players[i].id.toString());
        }
      }
      if(count > mostSkins){
        mostSkins = count;
      }
      count = 0;
    }
    print('Most Skins: $mostSkins');
  }

  displayPlayerSkins(Player p, int numSkins, BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
   
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
            //name
            child: Center(child: Text(p.firstName, overflow: TextOverflow.ellipsis, style: Theme.of(context).primaryTextTheme.headline4)),
          ),
          //This will be the skins 
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: numSkins >= mostSkins && mostSkins != 0 ? themeProvider.getGreen() : Colors.grey,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            //Num Skins
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
            children: widget.match.players.map((e) { 

              int count = 0;

              for(int i = 0; i < widget.match.gamePlayerPoints.length; i++){
                //We want to check all skins points
                if(widget.match.gamePlayerPoints[i].gameId == 3 && widget.match.gamePlayerPoints[i].playerId == e.id && widget.match.gamePlayerPoints[i].pointId != 0){
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