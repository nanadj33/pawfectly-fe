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
<<<<<<< HEAD
            SingleChildScrollView(
              child: Positioned(
                child: Form(
                key: _registerController.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    SizedBox(height: 225),
                      _buildTextField(
                        controller: _registerController.emailController,
                        hintText: "e-mail",
                        prefixIcon: SvgPicture.asset("assets/email.svg", color: Color(0xffCC5946), width: 24,),
                        keyboardType: TextInputType.emailAddress,
                        validator: _registerController.validateEmail,
                      ),
                      _buildTextField(
                        controller: _registerController.nameController,
                        hintText: "Full Name",
                        prefixIcon: SvgPicture.asset("assets/id-card.svg", color: Color(0xffCC5946), width: 24,),
                      ),
                      _buildTextField(
                        controller: _registerController.usernameController,
                        hintText: "Username",
                        prefixIcon: SvgPicture.asset("assets/username.svg"),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 6) {
                            return 'Username must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        controller: _registerController.phoneController,
                        hintText: "Phone Number",
                        prefixIcon: SvgPicture.asset("assets/telephone-call.svg", color: Color(0xffCC5946), height: 24,),
                        keyboardType: TextInputType.phone,
                        validator: _registerController.validatePhone,
                      ),
                      _PasswordField(
                        controller: _registerController.passwordController,
                        context: context,
                        hintText: "Password",
                        prefixIcon: SvgPicture.asset("assets/padlock.svg",color: Color(0xffCC5946), height: 30,),
                        validator: (value) {
                          final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(value ?? '');
                          final hasNumber = RegExp(r'\d').hasMatch(value ?? '');

                          if (value == null ||
                              value.isEmpty ||
                              !hasLetter ||
                              !hasNumber) {
                            return 'Password must contain at least one number';
                          }
                          return null;
                        },
                      ),

                      _PasswordField(
                        controller: _registerController.conpasswordController,
                        context: context,
                        hintText: "Confirm Password",
                        prefixIcon: SvgPicture.asset("assets/padlock.svg",color: Color(0xffCC5946), height: 30,),
                        validator: (value) {
                          final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(value ?? '');
                          final hasNumber = RegExp(r'\d').hasMatch(value ?? '');

                          if (value == null ||
                              value.isEmpty ||
                              !hasLetter ||
                              !hasNumber) {
                            return 'Password must contain at least one number';
                          }
                          return null;
                        },
                      ),

                      
                      SizedBox(height: 12),
                      _buildElevatedButton(
                        onPressed: () {
                          _registerController.register(context);
                        },
                        label: "Get Started",
                      ),
                  ],
                )
              ),
              ),
            ),

=======
>>>>>>> db74c4200113538d3cc88c65c20c32f0a1bf85b1
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
<<<<<<< HEAD
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
                    
                  ],
                ),
            ),
            
=======
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
>>>>>>> db74c4200113538d3cc88c65c20c32f0a1bf85b1
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
<<<<<<< HEAD
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: controller,
        validator: validator,
=======

  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: controller,
>>>>>>> db74c4200113538d3cc88c65c20c32f0a1bf85b1
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
<<<<<<< HEAD
          errorStyle: TextStyle(color: Colors.white),
        ),
        style: TextStyle(),
=======
        ),
        style: TextStyle(fontSize: 18),
>>>>>>> db74c4200113538d3cc88c65c20c32f0a1bf85b1
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

<<<<<<< HEAD
  TextStyle _textStyle({Color? color}) {
    return TextStyle(
      color: color ?? Color(0xffCC5946),
=======
  TextStyle _textStyle() {
    return TextStyle(
      color: Color(0xffCC5946),
>>>>>>> db74c4200113538d3cc88c65c20c32f0a1bf85b1
      fontSize: 18,
      fontWeight: FontWeight.normal,
    );
  }
}
<<<<<<< HEAD


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
=======
>>>>>>> db74c4200113538d3cc88c65c20c32f0a1bf85b1
