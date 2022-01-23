import 'Hole.dart';

class TeeBox {

    int id;
    int courseId;
    String name;
    int slope;
    int par;
    int adjustment;
    double rating;
    int teeBoxType;
    List<Hole> holes = [];

    TeeBox(this.id, this.courseId, this.name, this.slope, this.rating, this.teeBoxType, this.par, this.adjustment);

    TeeBox.fromTeeBox({
      required this.id, 
      required this.courseId, 
      required this.name, 
      required this.slope, 
      required this.rating,
      required this.teeBoxType,
      required this.par,
      required this.adjustment,
      required this.holes
    });

    factory TeeBox.fromJson(dynamic res){
      List<dynamic> holes = res['holes'];
      return TeeBox.fromTeeBox(
        id: res['id'],
        courseId: res['courseId'],
        name: res['name'],
        slope: res['slope'],
        par: res['par'],
        rating: res['rating'],
        teeBoxType: res['type'],
        adjustment: res['adjustment'],
        holes: holes.map((e) => Hole.fromJson(e)).toList()
      );
    }
}