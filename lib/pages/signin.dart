import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pawfectly/controllers/login_controller.dart';
import 'package:pawfectly/pages/forumpage.dart';
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
                  _TextField(
                    controller: _loginController.usernameController,
                    context: context,
                    hintText: "Username",
                    prefixIcon: SvgPicture.asset("assets/username.svg"),
                    validator: _loginController.validateUsername,
                  ),
                  _PasswordField(
                    controller: _loginController.passwordController,
                    context: context,
                    hintText: "Password",
                    prefixIcon: SvgPicture.asset("assets/padlock.svg",color: Color(0xffCC5946), height: 30,),
                    validator: _loginController.validatePassword,
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
      onPressed: () async{
        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ForumPage()),
                        );

        // bool loginResult = await _loginController.login(context);

        // if (loginResult) {
        //   Navigator.pushReplacement(
        //                   context,
        //                   MaterialPageRoute(builder: (context) => ForumPage()),
        //                 );
        // } else {
          
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text("Login failed. Please try again.")),
        //   );
        // }
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

class _PasswordField extends StatefulWidget {
  const _PasswordField({
    Key? key,
    required this.controller,
    required this.context,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final BuildContext context;
  final String hintText;
  final Widget prefixIcon;
  final String? Function(String?)? validator;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
      child: TextFormField(
        controller: widget.controller,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          fillColor: Color(0xffFCF2F1),
          filled: true,
          hintText: widget.hintText,
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
            child: widget.prefixIcon,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            child: Icon(
              isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Color(0xffCC5946),
            ),
          ),
          errorStyle: TextStyle(color: Colors.white),
        ),
        style: TextStyle(fontSize: 18),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key? key,
    required this.controller,
    required this.context,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final BuildContext context;
  final String hintText;
  final Widget prefixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
      child: TextFormField(
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
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: prefixIcon,
          ),
          errorStyle: TextStyle(color: Colors.white),
        ),
        style: TextStyle(fontSize: 18),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
