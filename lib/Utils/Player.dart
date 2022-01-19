class Player {

  int id;
  String name;
  String firstName;
  String lastName;
  int handicap;
  

  Player(this.id, this.firstName, this.lastName, this.name, this.handicap) ;


  Player.fromPlayer({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.handicap
  });

  factory Player.fromJson(dynamic res) {
    return Player.fromPlayer(
        id: res['id'],
        name: res['name'],
        firstName: res['firstName'],
        lastName: res['lastName'],
        handicap: res['handicap']
      );
  }

  
}