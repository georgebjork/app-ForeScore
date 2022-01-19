class Point {

  int id; 
  String name;
  String description;
  PointType type;

  Point(this.id, this.name, this.description, this.type);
}


class PointType {
  int id; 
  PointType(this.id);
}