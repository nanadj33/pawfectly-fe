import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawfectly/pages/signin.dart';

import '../constants/constants.dart';

class RegisterController extends GetxController {
  final isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conpasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future register(BuildContext context) async {
    try {
      isLoading.value = true;
      var data = {
        'name': nameController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': conpasswordController.text,
        'phone': phoneController.text,
      };

      final dio = Dio();
      final response = await dio.post('${url}register',
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          }));
      print(response.data.toString());
      const errorInfo = SnackBar(content: Text('You have registered!'));
      ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
          fullscreenDialog: true,
        ),
      );
    } on DioException catch (e) {
      print("Error catch");
      print(e.response!.data['message']);
      final errorInfo = SnackBar(content: Text(e.response!.data['message']));
      ScaffoldMessenger.of(context).showSnackBar(errorInfo);
    }
  }
}
