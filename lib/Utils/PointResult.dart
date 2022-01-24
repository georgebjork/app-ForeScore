
import 'package:golf_app/Utils/Point.dart';

class PointResult{

  int pointId;
  int won;
  dynamic value;

  PointResult(this.pointId, this.won, this.value);

  PointResult.fromPointResult({
    required this.pointId,
    required this.won,
    required this.value
  });

  factory PointResult.fromJson(dynamic res){
    return PointResult.fromPointResult(
      pointId: res['pointId'],
      won: res['won'],
      value: res['value']
    );
  }
}