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
  int? campaignsCount;
  bool? isVerified;
  bool? isMember;
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
    this.campaignsCount,
    this.isVerified,
    this.isMember,
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
      coverURL: json['bannerUrl'],
      profileURL: json['iconUrl'],
      spaceMembersCount: json['spaceMembersCount'],
      campaignsCount: json['campaignsCount'],
      isVerified: json['isVerified'],
      isMember: json['isMember'],
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
      'isVerified': isVerified,
      'isMember': isMember,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
