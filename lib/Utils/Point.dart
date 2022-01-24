class Point {

  int id; 
  String name;
  String description;
  PointType type;

  Point(this.id, this.name, this.description, this.type);

  Point.fromPoint({
    required this.id,
    required this.name,
    required this.description, 
    required this.type
  });

  factory Point.fromJson(dynamic res){
    return Point.fromPoint(
      id: res['id'],
      name: res['name'],
      description: res['description'],
      type: PointType(res['type'])
    );
  }
}


class PointType {
  int id; 
  PointType(this.id);
}