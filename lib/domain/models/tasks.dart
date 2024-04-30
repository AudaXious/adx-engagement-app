class Task {
  final String uuid;

  Task({
    required this.uuid,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
    };
  }
}
