class DiscussionPost {
  int postId;
  int userId;
  String name;
  String? profilePictureUrl;
  String title;
  String description;
  List<dynamic>? imageUrl;
  List<dynamic>? tags;
  int likesCount;
  String createdAt;

  DiscussionPost({
    required this.postId,
    required this.userId,
    required this.name,
    this.profilePictureUrl,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.tags,
    required this.likesCount,
    required this.createdAt,
  });
  factory DiscussionPost.fromJson(Map<String, dynamic> json) {
    return DiscussionPost(
      postId: json["id"],
      userId: json["user_id"],
      name: json["name"],
      title: json["title"],
      profilePictureUrl: json["profile_picture_url"],
      description: json["desc"],
      imageUrl: json["post_images"],
      tags: json["tags"],
      likesCount: json["likes_count"],
      createdAt: json["created_at"],
    );
  }
}
