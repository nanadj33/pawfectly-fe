import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawfectly/pages/signin.dart';

import '../constants/constants.dart';

class RegisterController extends GetxController {
<<<<<<< HEAD
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
=======
>>>>>>> db74c4200113538d3cc88c65c20c32f0a1bf85b1
  final isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conpasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
<<<<<<< HEAD
  

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty || value.length <= 8 || value.length >=14) {
      return 'Phone number must be at least 9-13 digits';
    }
    return null;
  }

  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  Future<void> register(BuildContext context) async {
    try {
      isLoading.value = true;

      if (formKey.currentState!.validate()) {
        var data = {
          'name': nameController.text,
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'password_confirmation': conpasswordController.text,
          'phone': phoneController.text,
        };

        final dio = Dio();
        final response = await dio.post(
          '${url}register',
          data: data,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ),
        );

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
      }
=======

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
>>>>>>> db74c4200113538d3cc88c65c20c32f0a1bf85b1
    } on DioException catch (e) {
      print("Error catch");
      print(e.response!.data['message']);
      final errorInfo = SnackBar(content: Text(e.response!.data['message']));
      ScaffoldMessenger.of(context).showSnackBar(errorInfo);
<<<<<<< HEAD
    } finally {
      isLoading.value = false;
=======
>>>>>>> db74c4200113538d3cc88c65c20c32f0a1bf85b1
    }
  }
}
