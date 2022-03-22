
import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Pages/SelectTeeBox.dart';
import 'package:golf_app/Utils/CreateMatch.dart';
import 'package:golf_app/Utils/Providers/ThemeProvider.dart';
import 'package:golf_app/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Components/NavigationWidget.dart';
import '../Components/SearchBar.dart';
import '../Utils/Player.dart';

class AddPlayers extends StatefulWidget {

  //This will be the new match we are creating
  final CreateMatch newMatch;
  //Constructor
  const AddPlayers({Key? key, required this.newMatch}) : super(key: key);
  
  @override
  AddPlayersState createState() => AddPlayersState();
}

class AddPlayersState extends State<AddPlayers> {
  
  List<Player> friends = [];
  List<Player> friendsSearch = [];

  @override
  void initState() {
    getFriends();
    super.initState();
  }

  getFriends() async {
    friends = await service.getFriends();
    friendsSearch = friends;
    setState(() {});
    return friends;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

            //Title
            Text('Add Players', style: Theme.of(context).primaryTextTheme.headline2),
            const SizedBox(height: 10,),
            
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10), 
              child: SearchBar(
                constData: friends, 
                data: friendsSearch, 
                searchResultChanged: (updatedList) => setState(() => friendsSearch = updatedList.cast<Player>())
              )
            ),

            //Friends section
            Text('Friends', style: Theme.of(context).primaryTextTheme.headline3),

            //Show friends list
            ShowFriends(
              friends: friendsSearch,
              onPlayersChanged: (players) => widget.newMatch.setPlayer(players)
            ),

            //Nav buttons
            NavigationWidget(
              btn1text: 'Prev',
              btn1onPressed: () => Navigator.pop(context),
              btn2text: 'Next',
              btn2onPressed: () {
                //If no players are selected then dont let the player go to the next page
                if(widget.newMatch.players.isEmpty){
                  context.showSnackBar(message: "At least one player must be selected", backgroundColor: Colors.red);
                } else{
                 Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SelectTeeBox(newMatch: widget.newMatch)));
                }
              }, 
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

class ShowFriends extends StatefulWidget {
  //This will be triggered on a course change
  final ValueChanged<List<Player>> onPlayersChanged;
  //Hold all friends
  List<Player> friends = [];
  //Constructor
  ShowFriends({Key? key, required this.onPlayersChanged, required this.friends}) : super(key: key);

  @override
  ShowFriendsState createState() => ShowFriendsState();
}

class ShowFriendsState extends State<ShowFriends> {

  
  //List of selected players in match=
  List<Player> selectedPlayers = [];
  
  @override
  void initState() {
    super.initState();
  }

  //Run api request and return the list of friends
  // getFriends() async {
  //   friends = await service.getFriends();
  //   return friends;
  // }

  @override
  Widget build(BuildContext context) {
    if(widget.friends.isEmpty){
      return Expanded(child: Center(child: CircularProgressIndicator(color: context.read<ThemeProvider>().getGreen(), strokeWidth: 6.0)));
    }
    return Expanded(
      //List view of friends
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
        ),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.friends.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              setState(() {
                //if tapped and exists within list, then we should remove the player
                if(selectedPlayers.contains(widget.friends[index])){
                  //Remove from list
                  selectedPlayers.remove(widget.friends[index]);
                  //Give updated list
                  widget.onPlayersChanged(selectedPlayers);
                }
                //add player to the selected player list. set state to rerender 
                else{
                  //Add player
                  selectedPlayers.add(widget.friends[index]);
                  //Give updated list
                  widget.onPlayersChanged(selectedPlayers);
                }
              });
            },
            //if in the list then set checkmark to true
            leading: selectedPlayers.contains(widget.friends[index]) == true ? const CheckMarkBox(isChecked: true) : const CheckMarkBox(isChecked: false),
            title: Text(
              widget.friends[index].firstName + ' ' + widget.friends[index].lastName,
              style: Theme.of(context).primaryTextTheme.headline4,
            ),
            subtitle: Text(
              'Hdcp: ' + widget.friends[index].handicap.toString(),
              style: Theme.of(context).primaryTextTheme.headline5
            ),
            trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.star))
          );
        }
      )
    );
  }
}