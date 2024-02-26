class Feed {
  String? description;
  int? id;
  int? points;
  String? reward;
  Map<String, String>? tasks;
  String? title;

  Feed({
    this.description,
    this.id,
    this.points,
    this.reward,
    this.tasks,
    this.title,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      description: json['description'],
      id: json['id'],
      points: json['points'],
      reward: json['reward'],
      tasks: Map<String, String>.from(json['tasks']),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'id': id,
      'points': points,
      'reward': reward,
      'tasks': tasks,
      'title': title,
    };
  }
}
