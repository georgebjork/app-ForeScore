
import 'package:flutter/cupertino.dart';

//this wil hold all necessary information about our user
class UserProvider extends ChangeNotifier{

  String firstName = "George";
  String lastName = "Bjork";

  double handicap = 10.2;

  getFirstName() => firstName;
  getHandicap() => handicap;

}