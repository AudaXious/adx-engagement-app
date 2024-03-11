class User {
  String? id;
  String? email;
  bool? isVerified;
  List? tags;
  List? links;
  String? uuid;
  String? createdAt;
  String? updatedAt;
  int? version;
  String? username;
  String? token;

  User({
    this.id,
    this.email,
    this.isVerified,
    this.tags,
    this.links,
    this.uuid,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.username,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      isVerified: json['isVerified'],
      tags: json['tags'],
      links: json['links'],
      uuid: json['uuid'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
      username: json['username'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'isVerified': isVerified,
      'tags': tags,
      'links': links,
      'uuid': uuid,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
      'username': username,
      'token': token,
    };
  }
}
