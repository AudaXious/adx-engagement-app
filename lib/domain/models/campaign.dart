import 'package:audaxious/domain/models/tasks.dart';

class Campaign {
  String? description;
  int? id;
  int? points;
  String? reward;
  Tasks? tasks;
  String? title;
  String? spaceProfile;

  Campaign({
    this.description,
    this.id,
    this.points,
    this.reward,
    this.tasks,
    this.title,
    this.spaceProfile,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      description: json['description'],
      id: json['id'],
      points: json['points'],
      reward: json['reward'],
      tasks: json['tasks'] != null ? Tasks.fromJson(json['tasks']) : null,
      title: json['title'],
      spaceProfile: json['author_profile'],
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
      'author_profile': spaceProfile,
    };
  }
}
