import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Stat {
  String type;
  int number; 
  Color color;

  Stat({required this.type, required this.color, required this.number});
}