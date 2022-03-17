
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Pages/EnterScore.dart';
import 'package:golf_app/Pages/all.dart';
import 'package:golf_app/Utils/Match.dart';
import 'package:golf_app/Utils/Providers/MatchSetUpProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Components/NavigationWidget.dart';
import '../Utils/CreateMatch.dart';
import '../Utils/Game.dart';
import '../Utils/Providers/MatchProvider.dart';
import '../Utils/constants.dart';

class SelectGame extends StatefulWidget {
  
  CreateMatch newMatch;
  SelectGame({Key? key, required this.newMatch}) : super(key: key);

  @override
  SelectGameState createState() => SelectGameState();
}

class SelectGameState extends State<SelectGame> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: null,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Games', style: Theme.of(context).primaryTextTheme.headline2),
            const SizedBox(height: 10,),

            //Display Games
            Text('Games', style: Theme.of(context).primaryTextTheme.headline3),

            Games(
              onGamesChanged: (value) => widget.newMatch.setGames(value),
            ),

            NavigationWidget(
              btn1text: 'Prev',
              btn1onPressed: () => Navigator.pop(context),

              btn2text: 'Create Match',
              btn2onPressed: () async {
                //Match m = await service.getMatch(255);
                // Match m = await context.read<MatchSetUpProvider>().createMatch();
                // context.read<MatchProvider>().setMatch(m);
                // Navigator.pushNamedAndRemoveUntil(context, '/EnterScore', ModalRoute.withName('/Home'));

                //Create the match
                Match m = await widget.newMatch.createMatch();
                context.read<MatchProvider>().setMatch(m);
                Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.rightToLeft, child: EnterScore(match: m)), ModalRoute.withName('/Home'));
              },

              btn3text: 'Cancel',
              btn3onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/Home'))
            ),

            const SizedBox(height: 30)
          ]
        ),
      ),
    );
  }
}


class Games extends StatefulWidget {
  //This will be triggered on a course change
  final ValueChanged<List<Game>> onGamesChanged;
  List<Game> games = [Game(3, 'Skins'), Game(4, 'Nassau')];

  Games({Key? key, required this.onGamesChanged});

  GamesState createState() => GamesState();
}

class GamesState extends State<Games> {

  List<Game> selectedGames = [];

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: widget.games.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
        ),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: selectedGames.contains(widget.games[index]) ? const CheckMarkBox(isChecked: true) : const CheckMarkBox(isChecked: false),
            title: Text(widget.games[index].name, style: Theme.of(context).primaryTextTheme.headline4),
            onTap: () {
              setState(() {
                if(selectedGames.contains(widget.games[index])){
                  //Remove from list
                  selectedGames.remove(widget.games[index]);
                  //Update match
                  widget.onGamesChanged(selectedGames);
                } else {
                  //add to list
                  selectedGames.add(widget.games[index]);
                  //update match
                  widget.onGamesChanged(selectedGames);
                }
              });
            },
          );
        }
      )
    );
  }
}