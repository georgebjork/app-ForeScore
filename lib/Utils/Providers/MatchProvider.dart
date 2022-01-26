
import 'package:flutter/cupertino.dart';
import '../Match.dart';

class MatchProvider extends ChangeNotifier{

  late Match match;

  MatchProvider();


  void setMatch(Match m){
    match = m;
  }
}