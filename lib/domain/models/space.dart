class Space {
  String? name;
  String? description;

  Space({
    this.name,
    this.description,
  });

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}
