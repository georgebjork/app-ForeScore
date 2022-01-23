
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Utils/Providers/MatchSetUpProvider.dart';
import 'package:golf_app/Utils/Providers/ThemeProvider.dart';
import 'package:provider/provider.dart';

import '../Components/NavWidget.dart';
import '../Utils/Providers/UserProvider.dart';

class AddPlayers extends StatefulWidget {
  @override
  AddPlayersState createState() => AddPlayersState();
}

class AddPlayersState extends State<AddPlayers> {
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
            Text('Add Players', style: Theme.of(context).primaryTextTheme.headline2),
            const SizedBox(height: 10,),

            Text('Friends', style: Theme.of(context).primaryTextTheme.headline3),
            Friends(),


            NavWidget(
              btn1text: 'Prev',
              btn1onPressed: () => Navigator.pop(context),
              btn2text: 'Next',
              btn2onPressed: () {},
              btn3text: 'Cancel',
              btn3onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/Home'))
            ),

            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}

class Friends extends StatefulWidget {
  @override
  FriendsState createState() => FriendsState();
}

class FriendsState extends State<Friends> {
  
  void initState() {

  }

  Widget build(BuildContext context) {
    
    final match = context.read<MatchSetUpProvider>();
    return Expanded(
      child: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.friends.isEmpty ? provider.getFriends() : null,
            builder: (context, snapshot) {
              if(provider.friends.isEmpty == true){
                return Center(child: CircularProgressIndicator(color: context.read<ThemeProvider>().getGreen(), strokeWidth: 6.0,));
              }
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                shrinkWrap: true,
                itemCount: provider.friends.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        //if tapped and exists within list, then we should remove the player
                        if(match.selectedPlayers.contains(provider.friends[index])){
                          match.removePlayer(provider.friends[index]);
                        }
                        //add player to the selected player list. set state to rerender 
                        else{
                          match.addPlayer(provider.friends[index]);
                        }
                      });
                    },
                    //if in the list then set checkmark to true
                    leading: match.selectedPlayers.contains(provider.friends[index]) == true ? const CheckMarkBox(isChecked: true) : const CheckMarkBox(isChecked: false),
                    title: Text(
                      provider.friends[index].firstName + ' ' + provider.friends[index].lastName,
                      style: Theme.of(context).primaryTextTheme.headline4,
                    ),
                    subtitle: Text(
                      'Hdcp: ' + provider.friends[index].handicap.toString(),
                      style: Theme.of(context).primaryTextTheme.headline5
                    ),
                    trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.star))
                  );
                }
              );
            }
          );
        }
      )
    );
  }
}