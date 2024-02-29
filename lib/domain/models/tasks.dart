class Tasks {
  String? follow;
  String? like;
  String? repost;

  Tasks({
    this.follow,
    this.like,
    this.repost,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      follow: json['follow'],
      like: json['like'],
      repost: json['repost'],
    );
  }

  int get length {
    int count = 0;
    if (follow != null) count++;
    if (like != null) count++;
    if (repost != null) count++;
    return count;
  }

  Map<String, dynamic> toJson() {
    return {
      'follow': follow,
      'like': like,
      'repost': repost,
    };
  }
}
