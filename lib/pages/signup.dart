import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pawfectly/controllers/register_controller.dart';
import 'package:pawfectly/pages/signin.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key});
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffCC5946),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                "assets/headerup.svg",
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Center(
                    child: Image(
                      image: AssetImage("assets/logo.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 75.0, vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: Text(
                            "SignIn",
                            style: _textStyle(),
                          ),
                        ),
                        Text(
                          "SignUp",
                          style: _textStyle(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                  _buildTextField(
                    controller: _registerController.emailController,
                    hintText: "e-mail",
                    prefixIcon: SvgPicture.asset("assets/username.svg"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildTextField(
                    controller: _registerController.nameController,
                    hintText: "Full Name",
                    prefixIcon: SvgPicture.asset("assets/username.svg"),
                  ),
                  _buildTextField(
                    controller: _registerController.usernameController,
                    hintText: "Username",
                    prefixIcon: SvgPicture.asset("assets/username.svg"),
                  ),
                  _buildTextField(
                    controller: _registerController.phoneController,
                    hintText: "Phone Number",
                    prefixIcon: Icon(Icons.phone),
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextField(
                    controller: _registerController.passwordController,
                    hintText: "Password",
                    prefixIcon: SvgPicture.asset("assets/password.svg"),
                    obscureText: true,
                  ),
                  _buildTextField(
                    controller: _registerController.conpasswordController,
                    hintText: "Confirm Password",
                    prefixIcon: SvgPicture.asset("assets/password.svg"),
                    obscureText: true,
                  ),
                  SizedBox(height: 50),
                  _buildElevatedButton(
                    onPressed: () {
                      _registerController.register(context);
                    },
                    label: "Get Started",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required Widget prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    TextEditingController? controller,

  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          fillColor: Color(0xffFCF2F1),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 222, 136, 128),
          ),
          contentPadding: EdgeInsets.all(12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: prefixIcon,
          ),
        ),
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildElevatedButton({
    required VoidCallback onPressed,
    required String label,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Color(0xFF704520),
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 252, 196, 118),
        minimumSize: Size(111, 46),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      color: Color(0xffCC5946),
      fontSize: 18,
      fontWeight: FontWeight.normal,
    );
  }
}
