import 'package:flutter/cupertino.dart';

import '../Utils/Round.dart';
import '../Utils/Match.dart';

class ScorecardMatchWidget extends StatelessWidget {

  final Match match;

  const ScorecardMatchWidget({
    Key? key, 
    required this.match
  }) : super(key: key);

  
  Widget build(BuildContext context){
    return Center(child: Text('Scorecard for match ${match.id}'),);
  }
}