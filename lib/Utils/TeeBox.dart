class TeeBox {

    int id;
    int courseId;
    String name;
    int slope;
    int par;
    int adjustment;
    double rating;
    int teeBoxType;

    TeeBox(this.id, this.courseId, this.name, this.slope, this.rating, this.teeBoxType, this.par, this.adjustment);

    TeeBox.fromTeeBox({
      required this.id, 
      required this.courseId, 
      required this.name, 
      required this.slope, 
      required this.rating,
      required this.teeBoxType,
      required this.par,
      required this.adjustment
    });

    factory TeeBox.fromJson(dynamic res){
      return TeeBox.fromTeeBox(
        id: res['id'],
        courseId: res['courseId'],
        name: res['name'],
        slope: res['slope'],
        par: res['par'],
        rating: res['rating'],
        teeBoxType: res['type'],
        adjustment: res['adjustment']
      );
    }
}