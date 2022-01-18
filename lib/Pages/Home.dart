import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Utils/all.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../Components/NavWidget.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.menu_rounded),
      ),
      body: Container(
        child: Column(
          children: [
            PlayerDetails(),
            Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0), //add left right padding
                child: NavWidget(
                  btn1text: 'Stats',
                  btn1Color: themeProvider.getTan(),
                  btn1onPressed: () {},
                  btn2text: 'Friends',
                  btn2Color: themeProvider.getTan(),
                  btn2onPressed: () {},
                  btn3text: 'Start Round',
                  btn3Color: themeProvider.getOrange(),
                  btn3onPressed: () => Navigator.pushNamed(context, '/AddPlayers'),
                ))
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
        height: MediaQuery.of(context).size.height *
            0.3333, //height only takes up part of the screen
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
