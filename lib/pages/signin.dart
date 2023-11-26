import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pawfectly/controllers/login_controller.dart';
import 'package:pawfectly/pages/signup.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key});
  final LoginController _loginController = Get.put(LoginController());

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
                "assets/headerin.svg",
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
                  _buildSignInSignUpRow(context),
                  SizedBox(height: 60),
                  _buildTextField(
                    controller: _loginController.usernameController,
                    context: context,
                    hintText: "Username",
                    prefixIcon: SvgPicture.asset("assets/username.svg"),
                  ),
                  _buildTextField(
                    controller: _loginController.passwordController,
                    context: context,
                    hintText: "Password",
                    prefixIcon: SvgPicture.asset("assets/password.svg"),
                    obscureText: true,
                  ),
                  SizedBox(height: 50),
                  SvgPicture.asset("assets/hedgehogs.svg"),
                  _buildAlmostThereText(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInSignUpRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 75.0, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "SignIn",
            style: _textStyle(),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: Text(
              "SignUp",
              style: _textStyle(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String hintText,
    required Widget prefixIcon,
    bool obscureText = false,
    TextEditingController? controller,

  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
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
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: prefixIcon,
          ),
        ),
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildAlmostThereText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "we're\nalmost\nthere",
            style: TextStyle(
              color: Color(0xffFCF2F1),
              fontWeight: FontWeight.bold,
              fontSize: 40,
              height: 1,
            ),
          ),
          _buildGetStartedButton(context),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _loginController.login(context);
      },
      child: Text(
        "Get Started",
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
