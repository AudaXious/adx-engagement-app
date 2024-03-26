class Space {
  String? title;
  String? description;
  String? creatorUUID;
  List<dynamic>? tags;
  List<dynamic>? links;
  String? uuid;
  String? coverURL;
  String? profileURL;
  int? spaceMembersCount;
  String? createdAt;
  String? updatedAt;

  Space({
    this.title,
    this.description,
    this.creatorUUID,
    this.tags,
    this.links,
    this.uuid,
    this.profileURL,
    this.coverURL,
    this.spaceMembersCount,
    this.createdAt,
    this.updatedAt,
  });

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      title: json['title'],
      description: json['description'],
      creatorUUID: json['creator_uuid'],
      tags: json['tags'],
      links: json['links'],
      uuid: json['uuid'],
      coverURL: json['cover_url'],
      profileURL: json['profile_url'],
      spaceMembersCount: json['spaceMembersCount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'creator_uuid': creatorUUID,
      'tags': tags,
      'links': links,
      'uuid': uuid,
      'spaceMembersCount': spaceMembersCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
