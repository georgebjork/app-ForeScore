import 'package:flutter/material.dart';
import 'package:golf_app/Utils/Providers/MatchProvider.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(provider.match.course.name, style: Theme.of(context).primaryTextTheme.headline3),
                const SizedBox(height: 5,),
                Text(provider.displayCurrentHole(), style: Theme.of(context).primaryTextTheme.headline2),
                Text(provider.displayHoleDetails(), style: Theme.of(context).primaryTextTheme.headline4),
                const SizedBox(height: 10,),
        
                Expanded(child: Center(child: Text('Hello'),)),
        
                NavWidget(
                  btn1text: 'Prev',
                  btn1onPressed: () => provider.prevHole(),
                  btn2text: 'Next',
                  btn2onPressed: () => provider.nextHole(),
                  btn3text: 'Cancel',
                  btn3onPressed: () {}
                ),
                
                const SizedBox(height: 30)
              ]
            ),
          );
        }),
    );
  }
}