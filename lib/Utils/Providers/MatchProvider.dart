
import 'package:flutter/cupertino.dart';

class MatchProvider extends ChangeNotifier{

  late Match match;

  MatchProvider();
  
  MatchProvider.fromMatchProvider(this.match);
}