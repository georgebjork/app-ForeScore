import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'CustomNavButton.dart';

class NavWidget extends StatelessWidget {

  
    final String btn1text;
    final String btn2text;
    final String btn3text;
    final VoidCallback btn1onPressed;
    final VoidCallback btn2onPressed;
    final VoidCallback btn3onPressed;
    Color? btn1Color = HexColor("#CFB784"); //tan
    Color? btn2Color = HexColor("#C56824"); //orange
    Color? btn3Color = HexColor("#CFB784"); //red

    NavWidget({
      Key? key,
      required this.btn1text,
      required this.btn2text,
      required this.btn3text,
      required this.btn1onPressed,
      required this.btn2onPressed,
      required this.btn3onPressed,
      this.btn1Color,
      this.btn2Color,
      this.btn3Color,
    }) :super(key: key);



  
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
  
    return Container(
        child: Column(children: [
      SizedBox(height: _height / 30),
      //first 2 buttons
      Row(
        children: <Widget>[
          Expanded(
              child: CustomButton(
                  onPressed: btn1onPressed,
                  width: double.infinity,
                  text: btn1text,
                  color: btn1Color ?? HexColor("#CFB784")
          ),),
          SizedBox(width: _width / 10),
          Expanded(
              child: CustomButton(
                  onPressed: btn2onPressed,
                  width: double.infinity,
                  text: btn2text,
                  color: btn2Color ?? HexColor("#C56824"))),
        ],
      ),

      SizedBox(
        height: _height / 30,
      ),

      CustomButton(
          onPressed: btn3onPressed,
          width: double.infinity,
          text: btn3text,
          color: btn3Color ?? HexColor("#A13333")),
    ]));
  }
}
