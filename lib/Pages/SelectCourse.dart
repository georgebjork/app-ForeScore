
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/Components/CheckBox.dart';
import 'package:golf_app/Utils/Providers/ThemeProvider.dart';
import 'package:provider/provider.dart';

import '../Components/NavWidget.dart';
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
              btn2onPressed: () => Navigator.pushNamed(context, '/AddPlayers'),
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
      child: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.friends.isEmpty ? provider.getFriends() : null,
            builder: (context, snapshot) {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                shrinkWrap: true,
                itemCount: provider.friends.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CheckMarkBox(isChecked: false),
                    title: Text(
                      provider.friends[index].firstName + ' ' + provider.friends[index].lastName,
                      style: Theme.of(context).primaryTextTheme.headline4,
                    ),
                    subtitle: Text(
                      'Hdcp: ' + provider.friends[index].handicap.toString(),
                      style: Theme.of(context).primaryTextTheme.headline5
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