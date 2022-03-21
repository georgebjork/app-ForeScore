
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Pages/SelectGame.dart';
import 'package:golf_app/Utils/Match.dart';
import 'package:golf_app/Utils/Providers/MatchProvider.dart';
import 'package:golf_app/Utils/Providers/MatchSetUpProvider.dart';
import 'package:golf_app/Utils/TeeBox.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Components/NavigationWidget.dart';
import '../Utils/CreateMatch.dart';
import '../Utils/Providers/ThemeProvider.dart';
import '../Utils/constants.dart';


class SelectTeeBox extends StatefulWidget {

  CreateMatch newMatch;
  SelectTeeBox({Key? key, required this.newMatch}) : super(key: key);

  @override
  SelectTeeBoxState createState() => SelectTeeBoxState();
}

class SelectTeeBoxState extends State<SelectTeeBox> {

  @override
  void initState() {
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
            Text('Select TeeBox', style: Theme.of(context).primaryTextTheme.headline2),
            const SizedBox(height: 10,),

            Text('TeeBoxes', style: Theme.of(context).primaryTextTheme.headline3),

            TeeBoxSelection(
              onTeeBoxChanged: (value) => widget.newMatch.setTeeBox(value),
              teeboxes: widget.newMatch.selectedCourse.teeboxes,
            ),

            NavigationWidget(
              btn1text: 'Prev',
              btn1onPressed: () => Navigator.pop(context),
              btn2text: 'Next',
              btn2onPressed: () {
                if(widget.newMatch.selectedTeeBox == TeeBox(-1, -1, "null", -1, -1, -1, -1, -1)){
                  context.showSnackBar(message: "A Teebox must be selected", backgroundColor: Colors.red);
                } else {
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SelectGame(newMatch: widget.newMatch)));
                }
              },
              btn3text: 'Cancel',
              btn3onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/Home'))
            ),

            const SizedBox(height: 30)
          ]
        )
      ),
    );
  }
}

class TeeBoxSelection extends StatefulWidget {

  final ValueChanged<TeeBox> onTeeBoxChanged;
  List<TeeBox> teeboxes = [];

  TeeBoxSelection({Key? key, required this.onTeeBoxChanged, required this.teeboxes});

  @override
  TeeBoxSelectionState createState() => TeeBoxSelectionState();
}

class TeeBoxSelectionState extends State<TeeBoxSelection> {
  
  TeeBox selectedTeeBox = TeeBox(-1, -1, "null", -1, -1, -1, -1, -1);
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: widget.teeboxes.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
        ),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
                setState(() {
                  //provider.setTeeBox(provider.selectedCourse.teeboxes[index]);
                  selectedTeeBox = widget.teeboxes[index];
                  widget.onTeeBoxChanged(widget.teeboxes[index]);
                });
            },
            leading: selectedTeeBox == widget.teeboxes[index] ? const CheckMarkBox(isChecked: true) : const CheckMarkBox(isChecked: false),
            title: Text(
              widget.teeboxes[index].name,
              style: Theme.of(context).primaryTextTheme.headline4,
            ),
            subtitle: Text(
              widget.teeboxes[index].rating.toString() + '/' + 
              widget.teeboxes[index].slope.toString() + '/' +
              widget.teeboxes[index].par.toString(),
              style: Theme.of(context).primaryTextTheme.headline5
            ),
          );
        }
      )
    );
  }
}
