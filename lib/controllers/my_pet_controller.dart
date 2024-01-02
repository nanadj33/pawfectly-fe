import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawfectly/constants/my_pet_data.dart';
import 'package:pawfectly/controllers/encrypt_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';

class MyPetController extends GetxController {
  static Future<List<MyPet>> getPet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');

    try {
      final dio = d.Dio();
      final response = await dio.get(
        '${url}pet/${prefs.getString('id')}',
        options: d.Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Accept": "application/json",
          },
        ),
      );
      List jsonPets = response.data['data'];
      return jsonPets.map((pet) => MyPet.fromJson(pet)).toList();
    } catch (e) {
      print("Error: $e");
    }
    return [];
  }

  Future<void> addMyPet(MyPet dataPet, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    MyPet newPet = dataPet;
    d.FormData formData = d.FormData.fromMap({
      'name': newPet.name,
      'kind': newPet.kind,
      'breed': newPet.breed,
      'color': newPet.color,
      'gender': newPet.gender,
      'user_id': int.parse(prefs.getString('id')!),
      'birth_day': newPet.birthDay,
      'image_path': newPet.photoUrl == null
          ? null
          : await d.MultipartFile.fromFile(newPet.photoUrl!.path)
    });
    print(d.MultipartFile.fromFile(newPet.photoUrl!.path));
    try {
      final dio = d.Dio();
      final response = await dio.post(
        '${url}pet',
        data: formData,
        options: d.Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${newPet.name} successfully added")));
      } else {
        const errorInfo = SnackBar(content: Text("Operation failed"));
        ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> updateMyPet(MyPet dataPet, context, bool isUpdatePhoto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    MyPet newPet = dataPet;
    d.FormData formData = d.FormData.fromMap({
      'name': newPet.name,
      'kind': newPet.kind,
      'breed': newPet.breed,
      'color': newPet.color,
      'gender': newPet.gender,
      'birth_day': newPet.birthDay,
      'image_path': newPet.photoUrl == null
          ? null
          : await d.MultipartFile.fromFile(newPet.photoUrl!.path)
    });

    var formData2 = {
      'name': newPet.name,
      'kind': newPet.kind,
      'breed': newPet.breed,
      'color': newPet.color,
      'gender': newPet.gender,
      'birth_day': newPet.birthDay,
    };

    try {
      final dio = d.Dio();
      final response = await dio.post(
        '${url}pet/update/${newPet.id}',
        data: isUpdatePhoto ? formData : formData2,
        options: d.Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Update ${newPet.name} success")));
      } else {
        var errorInfo = SnackBar(content: Text("Update ${newPet.name} failed"));
        ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }
}
