class Replies {
  int? id;
  String? name;
  String? profilePictureUrl;
  String description;
  String? createdAt;

  Replies({
    this.id,
    this.name,
    this.profilePictureUrl,
    required this.description,
    this.createdAt,
  });
  factory Replies.fromJson(Map<String, dynamic> json) {
    return Replies(
      id: json["id"],
      name: json["name"],
      description: json["desc"],
      createdAt: json["created_at"],
      profilePictureUrl: json["profile_picture_url"],
    );
  }
}
