class LeaderBoard {
  String? profile;
  String? username;
  int? points;

  LeaderBoard({
    this.profile,
    this.username,
    this.points,
  });

  factory LeaderBoard.fromJson(Map<String, dynamic> json) {
    return LeaderBoard(
      username: json['username'],
      points: json['totalPoints'],
      profile: json['avatarUrl'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'totalPoints': points,
      'avatarUrl': profile,
    };
  }
}
