import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawfectly/controllers/encrypt_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'Username must be at least 6 characters';
    }
    return null;
  }

  String? validatePassword(String? value) {
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(value ?? '');
    final hasNumber = RegExp(r'\d').hasMatch(value ?? '');

    if (value == null || value.isEmpty || !hasLetter || !hasNumber) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  String? validateLogin(String? username, String? password) {
    if (username == null || username.isEmpty || username.length < 6) {
      return 'Username must be at least 6 characters';
    }

    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  Future<bool> login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading.value = true;
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      final deviceId = deviceInfo.id;
      var data = {
        'username': usernameController.text,
        'password': passwordController.text,
        'device_id': deviceId
      };

      final dio = Dio();
      final response = await dio.post('${url}login',
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          }));

      bool loginSuccess = response.data['success'] ?? false;

      if (loginSuccess) {
        prefs.setString('id', response.data['data']['id'].toString());
        prefs.setString('name', response.data['data']['name'].toString());
        prefs.setString(
            'username', response.data['data']['username'].toString());
        prefs.setString('phone', response.data['data']['phone'].toString());
        prefs.setString('email', response.data['data']['email'].toString());
        prefs.setString(
            'image', response.data['data']['image_path'].toString());
        prefs.setString(
            'token', encryptMyData(response.data['token'].toString()));
        print("Login successful");
      } else {
        print("Login failed");
      }

      return loginSuccess;
    } on DioError catch (e) {
      print("Error catch");
      print(e.response!.data['message']);
      final errorInfo = SnackBar(content: Text(e.response!.data['message']));
      ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
