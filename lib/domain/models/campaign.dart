class Campaign {
  String? description;
  int? uuid;
  int? points;
  String? reward;
  List<dynamic>? tasks;
  String? title;
  String? spaceProfile;
  String? spaceTitle;
  String? spaceUUID;
  int? taskCount;
  int? participants;
  bool? isVerified;
  String? endDate;

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
    this.endDate,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      description: json['description'],
      uuid: json['uuid'],
      points: json['points'],
      reward: json['reward'],
      tasks: json['tasks'],
      title: json['title'],
      spaceProfile: json['spaceIconUrl'],
      spaceTitle: json['space_title'],
      spaceUUID: json['space_uuid'],
      taskCount: json['taskCount'],
      participants: json['taskParticipantCount'],
      isVerified: json['isVerified'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'uuid': uuid,
      'points': points,
      'reward': reward,
      'tasks': tasks,
      'title': title,
      'spaceIconUrl': spaceProfile,
      'space_title': spaceTitle,
      'space_uuid': spaceUUID,
      'taskCount': taskCount,
      'taskParticipantCount': participants,
      'isVerified': isVerified,
    };
  }
}
