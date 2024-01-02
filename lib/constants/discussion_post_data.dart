import 'dart:io';

class DiscussionPostForm {
  int? id;
  String title;
  String description;
  List<File>? imagePath;
  List<dynamic>? imageUrl;
  List<dynamic> tags;

  DiscussionPostForm({
    this.id,
    required this.title,
    required this.description,
    this.imagePath,
    this.imageUrl,
    required this.tags,
  });
}
