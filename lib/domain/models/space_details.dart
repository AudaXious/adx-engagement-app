class SpaceDetails {
  String? title;
  String? description;
  String? creatorUUID;
  // List<String>? tags;
  // List<String>? links;
  String? uuid;
  String? coverURL;
  String? profileURL;
  String? createdAt;
  String? updatedAt;

  SpaceDetails({
    this.title,
    this.description,
    this.creatorUUID,
    // this.tags,
    // this.links,
    this.uuid,
    this.profileURL,
    this.coverURL,
    this.createdAt,
    this.updatedAt,
  });

  factory SpaceDetails.fromJson(Map<String, dynamic> json) {
    return SpaceDetails(
      title: json['title'],
      description: json['description'],
      creatorUUID: json['creator_uuid'],
      // tags: json['tags'],
      // links: json['links'],
      uuid: json['uuid'],
      coverURL: json['cover_url'],
      profileURL: json['profile_url'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'creator_id': creatorUUID,
      // 'tags': tags,
      // 'links': links,
      'uuid': uuid,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
