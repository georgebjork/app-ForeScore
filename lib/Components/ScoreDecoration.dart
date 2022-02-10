
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreDecoration extends StatelessWidget {
  
  const ScoreDecoration({
    Key? key,
    required this.score,
    required this.strokesToPar
  }) : super(key: key);

  final int score;
  final int strokesToPar;

  Widget build(BuildContext context) {
    //Return box for eagle or better
    if(strokesToPar < -1 && strokesToPar != 0){
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 40,
          height: 40,
          child: Center(child: Text(score.toString(), style: Theme.of(context).primaryTextTheme.headline3)),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.purpleAccent.shade100, width: 4)
        ))
      );
    }

    //Return box for birdie
    else if(strokesToPar == -1){
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 40,
          height: 40,
          child: Center(child: Text(score.toString(), style: Theme.of(context).primaryTextTheme.headline3)),
          decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.lightGreen.shade500, width: 4)
        ))
      );
    }
    //Return box for par
    else if(strokesToPar == 0){
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 40,
          height: 40,
          child: Center(child: Text(score.toString(), style: Theme.of(context).primaryTextTheme.headline3)),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen.shade200
        ))
      );
    }

    //Return for bogey
    else if(strokesToPar == 1){
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 40,
          height: 40,
          child: Center(child: Text(score.toString(), style: Theme.of(context).primaryTextTheme.headline3)),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.orange.shade200, width: 4)
        ))
      );
    }
    //Double bogey or worse
    else if(strokesToPar >= 2){
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 40,
          height: 40,
          child: Center(child: Text(score.toString(), style: Theme.of(context).primaryTextTheme.headline3)),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.grey.shade400, width: 4)
        ))
      );
    }
    //Base case
    else{
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(score.toString(), style: Theme.of(context).primaryTextTheme.headline3));
    }

  }
}