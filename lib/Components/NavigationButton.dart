import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

/*
  This button will be a basic button template.
  You can customize:
    - Text (will be required)
    - Color 
    - Width
    - void callback function
*/

class NavigationButton extends StatelessWidget {
  final String text;
  Color? color = HexColor('#89A057');
  double? width = double.infinity;
  VoidCallback? onPressed;

  //Constructor
  NavigationButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width,
    this.color,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //Set the width
      width: width,
      child: TextButton(
        //Function
        onPressed: onPressed,
        child: Center(
            //Text
            child: Text(text,
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold))),
        style: TextButton.styleFrom(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0),
            backgroundColor: color,
            //overlayColor: HexColor("#CFB784"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );
  }
}
