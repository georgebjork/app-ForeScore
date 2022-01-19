
import 'package:flutter/cupertino.dart';
import 'package:golf_app/Utils/Player.dart';
import 'package:golf_app/Utils/all.dart';

import '../Course.dart';

class MatchSetUpProvider extends ChangeNotifier {

  late List<Player> players;

  late Course selectedCourse;
  List<Course> favoriteCourses = [];


  Future<List<Course>> getFavoriteCourses() async {
    //get favorite courses from the api
    favoriteCourses = await service.getFavoriteCourses();
    return favoriteCourses;
  }
}