
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Utils/Providers/MatchSetUpProvider.dart';
import 'package:golf_app/Utils/Providers/ThemeProvider.dart';
import 'package:golf_app/Utils/constants.dart';
import 'package:provider/provider.dart';

import '../Components/NavWidget.dart';
import '../Utils/Course.dart';
import '../Utils/Providers/UserProvider.dart';

class SelectCourse extends StatefulWidget {
  @override
  SelectCourseState createState() => SelectCourseState();
}

class SelectCourseState extends State<SelectCourse> {
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
            FavoriteCourses(),


            NavWidget(
              btn1text: 'Prev',
              btn1onPressed: () => Navigator.pop(context),
              btn2text: 'Next',
              btn2onPressed: () {
                if(context.read<MatchSetUpProvider>().isCourseSelected == true){
                  Navigator.pushNamed(context, '/AddPlayers');
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
  @override
  FavoriteCoursesState createState() => FavoriteCoursesState();
}

class FavoriteCoursesState extends State<FavoriteCourses> {
  
  void initState() {

  }

  Widget build(BuildContext context) {

    return Expanded(
      child: Consumer<MatchSetUpProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.favoriteCourses.isEmpty ? provider.getFavoriteCourses() : null,
            builder: (context, snapshot) {
              if(provider.favoriteCourses.isEmpty == true){
                return Center(child: CircularProgressIndicator(color: context.read<ThemeProvider>().getGreen(), strokeWidth: 6.0,));
              }
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                shrinkWrap: true,
                itemCount: provider.favoriteCourses.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      //Sets the selected course. We need to update the state in order for it to re rerender
                      setState(() {
                        provider.setCourse(provider.favoriteCourses[index]);
                      });
                    },
                    //check if its equal to the seleced course so we can update the checkbox
                    leading:  provider.selectedCourse == provider.favoriteCourses[index] ? const CheckMarkBox(isChecked: true) : const CheckMarkBox(isChecked: false),
                    title: Text(
                      provider.favoriteCourses[index].name,
                      style: Theme.of(context).primaryTextTheme.headline4,
                    ),
                    trailing: IconTheme(data: Theme.of(context).iconTheme, child: Icon(Icons.star))
                  );
                }
              );
            }
          );
        }
      )
    );
  }
}