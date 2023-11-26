import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  Future login(BuildContext context) async {
    try {
      isLoading.value = true;
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      final deviceId = deviceInfo.id;
      print(deviceId);
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
      print(response.data.toString());
    } on DioException catch (e) {
      print("Error catch");
      print(e.response!.data['message']);
      final errorInfo = SnackBar(content: Text(e.response!.data['message']));
      ScaffoldMessenger.of(context).showSnackBar(errorInfo);
    }
  }
}
