import 'package:audaxious/domain/models/tasks.dart';

class Campaign {
  String? description;
  String? uuid;
  int? points;
  String? reward;
  Tasks? tasks;
  String? title;
  String? spaceProfile;
  String? spaceTitle;
  String? spaceUUID;
  int? taskCount;
  int? participants;
  bool? isVerified;

  Campaign({
    this.description,
    this.uuid,
    this.points,
    this.reward,
    this.tasks,
    this.title,
    this.spaceProfile,
    this.spaceTitle,
    this.spaceUUID,
    this.taskCount,
    this.participants,
    this.isVerified,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      description: json['description'],
      uuid: json['id'],
      points: json['points'],
      reward: json['reward'],
      // tasks: json['tasks'] != null ? Tasks.fromJson(json['tasks']) : null,
      title: json['title'],
      spaceProfile: json['iconUrl'],
      spaceTitle: json['space_title'],
      spaceUUID: json['space_uuid'],
      taskCount: json['taskCount'],
      participants: json['taskParticipantCount'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'id': uuid,
      'points': points,
      'reward': reward,
      // 'tasks': tasks,
      'title': title,
      'author_profile': spaceProfile,
      'space_title': spaceTitle,
      'space_uuid': spaceUUID,
      'taskCount': taskCount,
      'taskParticipantCount': participants,
      'isVerified': isVerified,
    };
  }
}
