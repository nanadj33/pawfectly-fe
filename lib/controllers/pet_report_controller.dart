import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawfectly/constants/pet_report_data.dart';
import 'package:pawfectly/controllers/encrypt_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';

class PetReportController extends GetxController {
  static Future<List<PetReport>> getAllPetReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    try {
      final dio = Dio();
      final response = await dio.get(
        '${url}pet/reports/all/${prefs.getString('id')}',
        options: Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Accept": "application/json",
          },
        ),
      );

      List jsonPets = response.data['data'];
      return jsonPets.map((pet) => PetReport.fromJson(pet)).toList();
    } catch (e) {
      print("Error: $e");
    }
    return [];
  }

  static Future<List<PetReport>> getEachPetReport(petId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    try {
      final dio = Dio();
      final response = await dio.get(
        '${url}pet/reports/$petId}',
        options: Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Accept": "application/json",
          },
        ),
      );

      List jsonPets = response.data['data'];
      return jsonPets.map((pet) => PetReport.fromJson(pet)).toList();
    } catch (e) {
      print("Error: $e");
    }
    return [];
  }

  Future<void> addPetReport(PetReport myPetReport, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    PetReport newPetReport = myPetReport;

    try {
      final dio = Dio();
      final response = await dio.post(
        '${url}pet/report',
        data: {
          'pet_id': newPetReport.id,
          'content': newPetReport.content,
          'report_type': newPetReport.report,
          'date_time': newPetReport.dateTime.toString().substring(0, 19),
        },
        options: Options(
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
            const SnackBar(content: Text("Report successfully added")));
      } else {
        const errorInfo = SnackBar(content: Text("Operation failed"));
        ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      }
    } catch (e) {
      print(newPetReport.id);
      print(newPetReport.content);
      print(newPetReport.report);
      print(newPetReport.dateTime.toString().substring(0, 19));
      print("Error: $e");
    }
  }
}
