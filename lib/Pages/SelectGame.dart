
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Utils/Match.dart';
import 'package:golf_app/Utils/Providers/MatchSetUpProvider.dart';
import 'package:provider/provider.dart';

import '../Components/NavWidget.dart';
import '../Utils/Providers/MatchProvider.dart';
import '../Utils/constants.dart';

class SelectGame extends StatefulWidget {
  @override
  SelectGameState createState() => SelectGameState();
}

class SelectGameState extends State<SelectGame> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            Games(),

            NavWidget(
              btn1text: 'Prev',
              btn1onPressed: () => Navigator.pop(context),

              btn2text: 'Next',
              btn2onPressed: () async {
                //Match m = await service.getMatch(119);
                Match m = await context.read<MatchSetUpProvider>().createMatch();
                context.read<MatchProvider>().setMatch(m);
                Navigator.pushNamedAndRemoveUntil(context, '/EnterScore', ModalRoute.withName('/Home'));
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
  GamesState createState() => GamesState();
}

class GamesState extends State<Games> {
   Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<MatchSetUpProvider> (
        builder: (context, provider, child) {
          return ListView.separated(
            itemCount: provider.games.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: provider.selectedGames.contains(provider.games[index]) ? const CheckMarkBox(isChecked: true) : const CheckMarkBox(isChecked: false),
              title: Text(provider.games[index].name, style: Theme.of(context).primaryTextTheme.headline4),
              onTap: () {
                if(provider.selectedGames.contains(provider.games[index])){
                  provider.selectedGames.remove(provider.games[index]);
                } else {
                  provider.selectedGames.add(provider.games[index]);
                }
                setState(() {});
              },
            );
          },
        );},
      ),
    );
  }
}