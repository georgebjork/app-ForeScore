
class Course {
  int id;
  String name;

  Course(this.id, this.name);

  Course.fromCourse({
    required this.id,
    required this.name
  });

  factory Course.fromJson(dynamic res){
    return Course.fromCourse(
      id: res['id'], 
      name: res['name']
    );
  }
}