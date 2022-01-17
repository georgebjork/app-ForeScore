import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';



class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}



final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: HexColor('#89A057'),
    secondary: HexColor("#CFB784"),
    tertiary: HexColor("#C56824"),
    error: HexColor("#A13333"),
    background: HexColor("#EEEEEE"), 
  )

);