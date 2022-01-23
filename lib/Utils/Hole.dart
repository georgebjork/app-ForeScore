
class Hole{
  int id;
  int number;
  int handicap;
  int par;
  int yardage;
  int holeType;

  Hole(this.id, this.number, this.handicap, this.par, this.yardage, this.holeType);

  Hole.fromHole({
    required this.id,
    required this.number, 
    required this.handicap,
    required this.par,
    required this.yardage, 
    required this.holeType
  });

  factory Hole.fromJson(dynamic res){
    return Hole.fromHole(
      id: res['id'],
      number: res['number'],
      handicap: res['handicap'],
      par: res['par'],
      yardage: res['yardage'],
      holeType: res['holeType']
    );
  }
}