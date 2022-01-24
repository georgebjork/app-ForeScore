
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Utils/Providers/MatchSetUpProvider.dart';
import 'package:provider/provider.dart';

import '../Components/NavWidget.dart';
import '../Utils/Providers/ThemeProvider.dart';

class SelectTeeBox extends StatefulWidget {
  @override
  SelectTeeBoxState createState() => SelectTeeBoxState();
}

class SelectTeeBoxState extends State<SelectTeeBox> {
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
            Text('Select TeeBox', style: Theme.of(context).primaryTextTheme.headline2),
            const SizedBox(height: 10,),

            Text('TeeBoxes', style: Theme.of(context).primaryTextTheme.headline3),
            TeeBoxSelection(),

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
        )
      ),
    );
  }
}

class TeeBoxSelection extends StatefulWidget {
  @override
  TeeBoxSelectionState createState() => TeeBoxSelectionState();
}

class TeeBoxSelectionState extends State<TeeBoxSelection> {
  
  void initState() {

  }

  Widget build(BuildContext context) {
  
    return Expanded(
      child: Consumer<MatchSetUpProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future:provider.courseTeeBoxes.isEmpty ? provider.getTeeBoxes() : null,
            builder: (context, snapshot) {
              if(provider.courseTeeBoxes.isEmpty == true){
                return Center(child: CircularProgressIndicator(color: context.read<ThemeProvider>().getGreen(), strokeWidth: 6.0,));
              }
              return ListView.separated(
                itemCount: provider.courseTeeBoxes.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                        setState(() {
                           provider.selectedTeeBox = provider.courseTeeBoxes[index];
                        });
                    },
                    leading: provider.selectedTeeBox == provider.courseTeeBoxes[index] ? const CheckMarkBox(isChecked: true) : const CheckMarkBox(isChecked: false),
                    title: Text(
                      provider.courseTeeBoxes[index].name,
                      style: Theme.of(context).primaryTextTheme.headline4,
                    ),
                    subtitle: Text(
                      provider.courseTeeBoxes[index].rating.toString() + '/' + 
                      provider.courseTeeBoxes[index].slope.toString() + '/' +
                      provider.courseTeeBoxes[index].par.toString(),
                      style: Theme.of(context).primaryTextTheme.headline5
                    ),
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