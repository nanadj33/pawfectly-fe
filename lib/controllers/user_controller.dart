import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:pawfectly/constants/constants.dart';
import 'package:pawfectly/constants/user_data.dart';
import 'package:pawfectly/controllers/encrypt_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  Future<void> updateUser(UserData dataUser, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var id = prefs.getString('id');

    UserData user = dataUser;
    d.FormData formData = d.FormData.fromMap({
      'name': user.name,
      'username': user.username,
      'email': user.email,
      'phone': user.phone,
      'image_path': user.imageFile == null
          ? null
          : await d.MultipartFile.fromFile(user.imageFile!.path)
    });
    try {
      final dio = d.Dio();
      final response = await dio.post(
        '${url}user/$id/update',
        data: formData,
        options: d.Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );
      print(response);
      if (response.statusCode == 200) {
        prefs.setString('id', response.data['data']['id'].toString());
        prefs.setString('name', response.data['data']['name'].toString());
        prefs.setString(
            'username', response.data['data']['username'].toString());
        prefs.setString('phone', response.data['data']['phone'].toString());
        prefs.setString('email', response.data['data']['email'].toString());
        prefs.setString(
            'image', response.data['data']['image_path'].toString());

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile successfully updated")));
      } else {
        const errorInfo = SnackBar(content: Text("Operation failed"));
        ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
