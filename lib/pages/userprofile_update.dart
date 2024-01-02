import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawfectly/constants/constants.dart';
import 'package:pawfectly/constants/user_data.dart';
import 'package:pawfectly/controllers/user_controller.dart';

class UpdateUserProfile extends StatefulWidget {
  final String email;
  final String name;
  final String username;
  final String phone;
  final String imageUrl;
  const UpdateUserProfile({
    super.key,
    required this.email,
    required this.name,
    required this.username,
    required this.phone,
    required this.imageUrl,
  });

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  TextEditingController emailCtl = TextEditingController();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  final ImagePicker imgpicker = ImagePicker();
  XFile? imageFile;
  getPhoto() async {
    try {
      var pickedImage = await imgpicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (pickedImage != null) {
        imageFile = XFile(pickedImage.path);
        setState(() {});
      } else {
        imageFile = null;
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  void initState() {
    super.initState();
    emailCtl = TextEditingController(text: widget.email);
    nameCtl = TextEditingController(text: widget.name);
    usernameCtl = TextEditingController(text: widget.username);
    phoneCtl = TextEditingController(text: widget.phone);
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFFF2DE),
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Color(0xff704520)),
        ),
        title: const Text(
          "My Profile",
          style:
              TextStyle(color: Color(0xff704520), fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xffFFF2DE),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center content vertically
                children: [
                  InkWell(
                    onTap: () {
                      getPhoto();
                    },
                    child: Stack(
                      children: [
                        widget.imageUrl == 'null' && imageFile == null
                            ? Container(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width /
                                          10,
                                    ),
                                  ],
                                ),
                              )
                            : ClipOval(
                                child: Container(
                                  width: deviceWidth / 4,
                                  height: deviceWidth / 4,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: imageFile == null
                                      ? Image.network(
                                          '$urlIp/storage/${widget.imageUrl}',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(imageFile!.path),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                        const Positioned(
                          bottom: 1,
                          right: 1,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Color(0xffCC5946),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 60),
                    child: Center(
                      child: Column(
                        children: [
                          MyTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Harap diisi";
                              }
                              return null;
                            },
                            label: "Email",
                            controller: emailCtl,
                          ),
                          MyTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Harap diisi";
                              }
                              return null;
                            },
                            label: "Username",
                            controller: usernameCtl,
                          ),
                          MyTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Harap diisi";
                              }
                              return null;
                            },
                            label: "Name",
                            controller: nameCtl,
                          ),
                          MyTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Harap diisi";
                              }
                              return null;
                            },
                            label: "Phone",
                            controller: phoneCtl,
                          ),
                          const SizedBox(height: 60),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffCC5946),
                              ),
                              onPressed: () {
                                UserController().updateUser(
                                    UserData(
                                      name: nameCtl.text,
                                      username: usernameCtl.text,
                                      phone: phoneCtl.text,
                                      email: emailCtl.text,
                                      imageFile: imageFile == null
                                          ? null
                                          : File(imageFile!.path),
                                    ),
                                    context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Pawfect!",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffFFF2DE)),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  bool? isReadOnly;
  final String? Function(String?)? validator;
  VoidCallback? onTap;

  MyTextField({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.onTap,
    this.isReadOnly,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Text(
          label,
          style: TextStyle(
              color: Color(0xffCC5946),
              fontWeight: FontWeight.w600,
              fontSize: deviceWidth / 25),
        ),
        const SizedBox(height: 5.0),
        TextFormField(
          onTap: onTap,
          readOnly: isReadOnly ?? false,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            fillColor: const Color(0xffFFC989),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color(0xff403D2F).withOpacity(.4),
            ),
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide.none,
            ),
            errorStyle: const TextStyle(color: Colors.black),
          ),
          style: TextStyle(
            fontSize: deviceWidth / 25,
            color: Color(0xffCC5946),
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
