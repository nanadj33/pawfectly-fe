import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pawfectly/controllers/login_controller.dart';
import 'package:pawfectly/pages/homePage.dart';
import 'package:pawfectly/pages/signup.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffCC5946),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    const SizedBox(height: 200),
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
                      prefixIcon: SvgPicture.asset(
                        "assets/padlock.svg",
                        color: const Color(0xffCC5946),
                        height: 30,
                      ),
                      validator: _loginController.validatePassword,
                    ),
                    const SizedBox(height: 50),
                    SvgPicture.asset("assets/hedgehogs.svg"),
                    _buildAlmostThereText(context),
                  ],
                ),
              ),
            ),
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
                  const Center(
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          const Text(
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
      onPressed: () async {
        // _showLoginSuccessPopup(context);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => HomePage(),
        //       fullscreenDialog: true,
        //     ),
        //   );

        String? username = _loginController.usernameController.text;
        String? password = _loginController.passwordController.text;

        // // Validasi login
        String? loginValidation =
            _loginController.validateLogin(username, password);
        if (loginValidation != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(loginValidation)));
          return;
        }

        // // Lakukan login
        bool loginSuccess = await _loginController.login(context);

        if (loginSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
              fullscreenDialog: true,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text("Login failed. Check your username and password.")));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 252, 196, 118),
        minimumSize: const Size(111, 46),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        "Get Started",
        style: TextStyle(
          color: Color(0xFF704520),
          fontSize: 16,
        ),
      ),
    );
  }

  void _showLoginSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: SvgPicture.asset(
                      "assets/succeed.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
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
          fillColor: const Color(0xffFCF2F1),
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 222, 136, 128),
          ),
          contentPadding: const EdgeInsets.all(12.0),
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
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xffCC5946),
            ),
          ),
          errorStyle: const TextStyle(color: Colors.white),
        ),
        style: const TextStyle(fontSize: 18),
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
          fillColor: const Color(0xffFCF2F1),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 222, 136, 128),
          ),
          contentPadding: const EdgeInsets.all(12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: prefixIcon,
          ),
          errorStyle: const TextStyle(color: Colors.white),
        ),
        style: const TextStyle(fontSize: 18),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
