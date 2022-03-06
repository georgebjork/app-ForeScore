import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  final Color _green = HexColor('#89A057');
  final Color _tan = HexColor("#CFB784");
  final Color _orange = HexColor("#C56824");
  final Color _red = HexColor("#A13333");

  ThemeProvider(this._themeData);

  getTheme() => _themeData;
  getGreen() => _green;
  getTan() => _tan;
  getOrange() => _orange;
  getRed() => _red;

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
    brightness: Brightness.light,
    scaffoldBackgroundColor: HexColor("#EEEEEE"),
    primaryColor: HexColor('#89A057'),
    colorScheme: ColorScheme.light(
      primary: HexColor('#89A057'),
    ),

    iconTheme: const IconThemeData(
      color: Colors.black,
      size: 30,
    ),

    primaryTextTheme: TextTheme(
      headline1: GoogleFonts.openSans( fontSize: 38, color: Colors.black),
      headline2: GoogleFonts.openSans( fontSize: 24, color: Colors.black),
      headline3: GoogleFonts.openSans( fontSize: 14, color: Colors.black),
      headline4: GoogleFonts.openSans( fontSize: 12, color: Colors.black),
      headline5: GoogleFonts.openSans( fontSize: 10, color: Colors.black),
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.openSans( fontSize: 38, color: Colors.white),
      headline2: GoogleFonts.openSans( fontSize: 24, color: Colors.white),
      headline3: GoogleFonts.openSans( fontSize: 14, color: Colors.white),
      headline4: GoogleFonts.openSans( fontSize: 12, color: Colors.white),
      headline5: GoogleFonts.openSans( fontSize: 10, color: Colors.white),
    ),
  );