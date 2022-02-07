import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Components/ScorecardMatchWidget.dart';
import 'package:golf_app/Utils/Providers/MatchSetUpProvider.dart';
import 'package:golf_app/Utils/ViewMatchArgs.dart';
import '../Utils/Match.dart';
import 'package:provider/provider.dart';



class ViewMatch extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    final args = ModalRoute.of(context)!.settings.arguments as ViewMatchArgs;

    String getPlayers(){
      String str = "";
      for(int i = 0; i < args.match.players.length; i++){
        str += args.match.players[i].firstName + " " + args.match.players[i].lastName[0] + ', ';
      }
      
      return str.substring(0, str.length-2);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Text(args.match.course.name, style: Theme.of(context).primaryTextTheme.headline2),
                  Text("Date: ", style: Theme.of(context).primaryTextTheme.headline3),
                  const SizedBox(height: 5),
                  Text("Players: " + getPlayers(), style: Theme.of(context).primaryTextTheme.headline3),
                  

                  const SizedBox(height: 10),
                  ScorecardMatchWidget(match: args.match)
                ]
              )
            )
          ]
        ),
      ),
    );
  }
} 