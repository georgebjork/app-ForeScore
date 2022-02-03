
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Utils/Providers/MatchSetUpProvider.dart';
import 'package:provider/provider.dart';

import '../Components/NavWidget.dart';

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
              btn2onPressed: () {},
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
            itemCount: provider.selectedCourse.teeboxes.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
            return ListTile();
          },
        );},
      ),
    );
  }
}