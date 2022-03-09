import 'package:flutter/material.dart';
import 'package:golf_app/Pages/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Pages/RoundSummary.dart';
import '../Utils/Providers/ThemeProvider.dart';

class NavBar extends StatefulWidget {

  int? index = 0;

  NavBar({Key? key, this.index}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          //Do nothing if its the current page we are on
          if(i == _currentIndex){}
          else{
            switch(i){
              case 0 : return Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Home()));
              case 1 : return Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SelectCourse()));
            }
          }
          setState(() => _currentIndex = i);
        },
        items: [
          /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home_outlined),
                title: const Text("Home"),
                selectedColor: themeProvider.getGreen(),
              ),

              /// New Match
              SalomonBottomBarItem(
                icon: const Icon(Icons.add_outlined),
                activeIcon: const Icon(Icons.add),
                title: Text(""),
                selectedColor: themeProvider.getGreen(),
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: const Icon(Icons.person_outline_outlined),
                activeIcon: const Icon(Icons.person),
                title: const Text("Profile"),
                selectedColor: themeProvider.getGreen(),
              ),
        ],
      ),
    );
  }
}