class Player {
  String firstName;
  String lastName;
  String uuid;
  

  Player(this.firstName, this.lastName, this.uuid) ;


  Player.fromPlayer({
    required this.firstName,
    required this.lastName,
    required this.uuid,
  });

  factory Player.fromJson(dynamic res) {
    return Player.fromPlayer(
        firstName: res['first_name'],
        lastName: res['last_name'],
        uuid: res['id'],
      );
  }

  
}