import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Components/ScorecardMatchWidget.dart';
import 'package:golf_app/Utils/Providers/MatchSetUpProvider.dart';
import 'package:golf_app/Utils/ViewMatchArgs.dart';
import '../Utils/Match.dart';
import 'package:provider/provider.dart';



class ViewMatch extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    final args = ModalRoute.of(context)!.settings.arguments as ViewMatchArgs;


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          ScorecardMatchWidget(match: args.match)
        ]
      ),
    );
  }
} 