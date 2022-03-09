import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Pages/AddPlayers.dart';
import 'package:golf_app/Utils/CreateMatch.dart';
import 'package:golf_app/Utils/Providers/ThemeProvider.dart';
import 'package:golf_app/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Components/NavWidget.dart';
import '../Utils/Course.dart';


class SelectCourse extends StatefulWidget {
  @override
  SelectCourseState createState() => SelectCourseState();
}

class SelectCourseState extends State<SelectCourse> {

  //This will be our new match
  CreateMatch newMatch = CreateMatch();


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
            Text('Select Course', style: Theme.of(context).primaryTextTheme.headline2),
            const SizedBox(height: 10,),

            Text('Favorite Courses', style: Theme.of(context).primaryTextTheme.headline3),

            //When the a new course is selected, the onChangedFunction will be triggered and the course will be set
            FavoriteCourses(
              onCourseChanged: (newCourse) => newMatch.setCourse(newCourse)
            ),


            NavWidget(
              btn1text: 'Prev',
              btn1onPressed: () => Navigator.pop(context),
              btn2text: 'Next',
              btn2onPressed: () {
                if(newMatch.selectedCourse != Course(-1, 'null')){
                 Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: AddPlayers(newMatch: newMatch)));
                } else{
                  context.showSnackBar(message: "A course must be selected", backgroundColor: Colors.red);
                }
              }, 
              btn3text: 'Cancel',
              btn3onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/Home'))
            ),

            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}

class FavoriteCourses extends StatefulWidget {
  //This will be triggered on a course change
  final ValueChanged<Course> onCourseChanged;

  FavoriteCourses({Key? key, required this.onCourseChanged})  : super(key: key) ;

  @override
  FavoriteCoursesState createState() => FavoriteCoursesState();
}

class FavoriteCoursesState extends State<FavoriteCourses> {

  //Hold a list of favorite courses
  List<Course> favoriteCourses = [];
  //The course to be selected
  Course selectedCourse = Course(-1, 'null');

  @override
  void initState() {}

  getFavoriteCourses() async {
    favoriteCourses =  await service.getFavoriteCourses();
    return favoriteCourses;
  }

  Widget build(BuildContext context) {

    return Expanded(
      child: FutureBuilder(
        future: favoriteCourses.isEmpty ? getFavoriteCourses() : null,
        builder: (context, snapshot) {
          if(snapshot.hasData == false){
            return Center(child: CircularProgressIndicator(color: context.read<ThemeProvider>().getGreen(), strokeWidth: 6.0));
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: favoriteCourses.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  //Sets the selected course. We need to update the state in order for it to re rerender
                  setState(() {
                    //Update selected course
                    selectedCourse = favoriteCourses[index];
                    //Trigger onchanged
                    widget.onCourseChanged(selectedCourse);
                  });
                },
                //check if its equal to the seleced course so we can update the checkbox
                leading:  selectedCourse == favoriteCourses[index] ? const CheckMarkBox(isChecked: true) : const CheckMarkBox(isChecked: false),
                title: Text(
                  favoriteCourses[index].name,
                  style: Theme.of(context).primaryTextTheme.headline4,
                ),
                trailing: IconTheme(data: Theme.of(context).iconTheme, child: const Icon(Icons.star))
              );
            }
          );
        }
      )
    );
  }
}