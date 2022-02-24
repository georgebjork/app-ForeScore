
import 'package:flutter/material.dart';

class Statscard extends StatelessWidget {

  final Color? color;
  final String title;
  Widget? body;
  //Graph leadingGraph

  Statscard({
     Key? key,
     required this.color,
     required this.title,
     this.body
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: double.infinity,
      child: Center(child: Text(title))
    );
  }
}