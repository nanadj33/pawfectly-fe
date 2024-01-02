import 'dart:io';

class UserData {
  String name;
  String username;
  String phone;
  String email;
  File? imageFile;
  UserData({
    required this.name,
    required this.username,
    required this.phone,
    this.imageFile,
    required this.email,
  });
}
