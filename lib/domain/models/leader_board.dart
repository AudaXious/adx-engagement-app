class LeaderBoard {
  int? id;
  String? profile;
  String? username;
  int? points;


  LeaderBoard({
    this.id,
    this.profile,
    this.username,
    this.points,
  });

  factory LeaderBoard.fromJson(Map<String, dynamic> json) {
    return LeaderBoard(
      id: json['_id'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
    };
  }
}
