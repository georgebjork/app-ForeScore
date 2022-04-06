import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Pages/EnterScore.dart';
import 'package:golf_app/Pages/ViewMatch.dart';
import 'package:golf_app/Pages/all.dart';
import 'package:golf_app/Utils/Match.dart';
import 'package:golf_app/Utils/all.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../Components/NavigationButton.dart';
import '../Components/NavigationWidget.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/NavBar.dart';

import '../Components/ScoreInputWidget.dart';
import 'MatchSummary.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    final _scoreController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.menu_rounded),
      ),
     // bottomNavigationBar: NavBar(index: 0),
      body: Container(
        child: Column(
          children: [
            PlayerDetails(),
            
            Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0), //add left right padding
                child: NavigationWidget(
                  btn1text: 'Stats',
                  btn1Color: themeProvider.getTan(),
                  btn1onPressed: () async {
                    Match m = await service.getMatch(119);
                    //Navigator.pushNamed(context, '/ViewMatch', arguments: ViewMatchArgs(m));
                    //Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: ViewMatch(match: m)));
                    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: MatchSummary(m)));
                  },

                  btn2text: 'Friends',
                  btn2Color: themeProvider.getTan(),
                  btn2onPressed: () {},

                  btn3text: 'Start Round',
                  btn3Color: themeProvider.getOrange(),
                  btn3onPressed: () => Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SelectCourse()))
                )),

            SizedBox(height: 50,),
            Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0), //add left right padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NavigationButton(
                      width: 200,
                      text: 'Resume Round',
                      color: themeProvider.getGreen(),
                      onPressed: () async {
                        Match m = await service.getMatch(int.parse(_scoreController.text));
                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: EnterScore(match: m)));
                      },
                    ),

                    SizedBox(
                      height: 50,
                      width: 60,
                      child: TextFormField(
                        showCursor: false,
                        textAlign: TextAlign.center, 
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 24),
                        controller: _scoreController,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.grey),
                          )
                        ),

                        onChanged: (string) async {
                          print('Match to get: ' + _scoreController.text);
                          
                        },
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class PlayerDetails extends StatefulWidget {
  @override
  PlayerDetailsState createState() => PlayerDetailsState();
}

class PlayerDetailsState extends State<PlayerDetails> {
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0), //add left right padding
        width: double.infinity, //width takes up whole screen
        height: MediaQuery.of(context).size.height*0.3333, //height only takes up part of the screen
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            //Add rounded border to the bottom of the container
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(35),
                bottomLeft: Radius.circular(35))),
        child: Consumer<UserProvider>(builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome,',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                provider.firstName,
                style: Theme.of(context).textTheme.headline2,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Handicap',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(provider.getHandicap().toString(),
                          style: Theme.of(context).textTheme.headline1),
                      Text(
                        'Low:',
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }));
  }
}


