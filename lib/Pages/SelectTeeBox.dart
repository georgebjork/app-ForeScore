
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Utils/Match.dart';
import 'package:golf_app/Utils/Providers/MatchProvider.dart';
import 'package:golf_app/Utils/Providers/MatchSetUpProvider.dart';
import 'package:provider/provider.dart';

import '../Components/NavWidget.dart';
import '../Utils/Providers/ThemeProvider.dart';
import '../Utils/constants.dart';


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
    final provider = context.read<MatchSetUpProvider>();

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
              btn2onPressed: context.read<MatchSetUpProvider>().isCourseSelected ? () => Navigator.pushNamed(context, '/SelectGame') : () => context.showSnackBar(message: "A course must be selected", backgroundColor: Colors.red),
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
          return ListView.separated(
            itemCount: provider.selectedCourse.teeboxes.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                    setState(() {
                      provider.setTeeBox(provider.selectedCourse.teeboxes[index]);
                    });
                },
                leading: provider.selectedTeeBox == provider.selectedCourse.teeboxes[index] ? const CheckMarkBox(isChecked: true) : const CheckMarkBox(isChecked: false),
                title: Text(
                  provider.selectedCourse.teeboxes[index].name,
                  style: Theme.of(context).primaryTextTheme.headline4,
                ),
                subtitle: Text(
                  provider.selectedCourse.teeboxes[index].rating.toString() + '/' + 
                  provider.selectedCourse.teeboxes[index].slope.toString() + '/' +
                  provider.selectedCourse.teeboxes[index].par.toString(),
                  style: Theme.of(context).primaryTextTheme.headline5
                ),
              );
            }
          );
        }
      )
    );
  }
}