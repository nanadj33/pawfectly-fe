import 'dart:io';

class MyPet {
  int? id;
  String name;
  String kind;
  String breed;
  String color;
  String gender;
  int userId;
  String birthDay;
  String? imagePath;
  File? photoUrl;

  MyPet({
    this.id,
    required this.name,
    required this.kind,
    required this.breed,
    required this.color,
    required this.gender,
    required this.userId,
    required this.birthDay,
    this.imagePath,
    required this.photoUrl,
  });

  factory MyPet.fromJson(Map<String, dynamic> json) {
    return MyPet(
      id: json["id"],
      name: json["name"],
      kind: json["kind"],
      breed: json["breed"],
      color: json["color"],
      gender: json["gender"],
      userId: json["user_id"],
      birthDay: json["birth_day"],
      imagePath: json["image_path"],
      photoUrl: null,
    );
  }
}
