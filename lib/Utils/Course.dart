
import 'TeeBox.dart';

class Course {

  int id;
  String name;
  //String state;
  List<TeeBox> teeboxes = [];

  Course(this.id, this.name);

  Course.fromCourse({
    required this.id,
    required this.name,
    required this.teeboxes
  });

  factory Course.fromJson(dynamic res){
    List<dynamic> teeBox = res['teeBoxes'];
    return Course.fromCourse(
      id: res['id'], 
      name: res['name'],
      teeboxes: teeBox.map((e) => TeeBox.fromJson(e)).toList()

    );
  }

  @override
  String toString() {
    return name;
  }
  
}