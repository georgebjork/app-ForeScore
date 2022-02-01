import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Utils/Providers/MatchProvider.dart';
import 'package:provider/provider.dart';
import '../Utils/constants.dart';

class ScoreInputWidget extends StatelessWidget {

  final String hintText;
  final _scoreController = TextEditingController();
  final int holeId;
  final int playerId;
  final int matchId;

  ScoreInputWidget({
    Key? key,
    required this.hintText,
    required this.holeId,
    required this.playerId,
    required this.matchId,
  }) : super(key: key);

  Widget build(BuildContext context){
    final matchProvider = context.read<MatchProvider>();
    return TextFormField(
      showCursor: false,
      textAlign: TextAlign.center, 
      keyboardType: TextInputType.number,
      style: Theme.of(context).primaryTextTheme.headline2,
      controller: _scoreController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).primaryTextTheme.headline2,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.grey),
        )
      ),

      onEditingComplete: () {
        print(_scoreController.text);
        matchProvider.postHoleScore(playerId, holeId, matchId, int.parse(_scoreController.text));
      },
    );
  }
}
