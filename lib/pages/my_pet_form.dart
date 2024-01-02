import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pawfectly/constants/my_pet_data.dart';
import 'package:pawfectly/controllers/my_pet_controller.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final nameCtl = TextEditingController();
  final kindCtl = TextEditingController();
  final breedCtl = TextEditingController();
  final colorCtl = TextEditingController();
  final birthdayCtl = TextEditingController();
  final genderCtl = TextEditingController();

  String genderPet = '';
  String birthdatePet = '';
  final addPetFormKey = GlobalKey<FormState>();

  final ImagePicker imgpicker = ImagePicker();
  XFile? imageFile;

  getPhotoPet() async {
    try {
      var pickedImage = await imgpicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (pickedImage != null) {
        imageFile = XFile(pickedImage.path);
        print(File(imageFile!.path));
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
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffCC5946),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffCC5946),
        title: const Text(
          'My Pet',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          addPetForm(deviceWidth),
        ],
      ),
    );
  }

  Widget addPetForm(deviceWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth / 20),
      child: Form(
          key: addPetFormKey,
          child: Column(
            children: [
              SizedBox(
                height: deviceWidth / 10,
              ),
              addPhoto(deviceWidth),
              SizedBox(
                height: deviceWidth / 15,
              ),
              MyTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harap diisi";
                  }
                  return null;
                },
                label: 'my name is...',
                hintText: "Your pet's name",
                controller: nameCtl,
              ),
              const SizedBox(height: 10.0),
              MyTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harap diisi";
                  }
                  return null;
                },
                label: "I'm a...",
                hintText: 'e.g: Cat',
                controller: kindCtl,
              ),
              const SizedBox(height: 10.0),
              MyTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harap diisi";
                  }
                  return null;
                },
                label: "specifically, I'm a",
                hintText: 'Breed, e.g: Perssian',
                controller: breedCtl,
              ),
              const SizedBox(height: 10.0),
              MyTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harap diisi";
                  }
                  return null;
                },
                label: "My color",
                hintText: 'e.g: Black',
                controller: colorCtl,
              ),
              const SizedBox(height: 10.0),
              MyTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harap diisi";
                  }
                  return null;
                },
                onTap: () async {
                  final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1000),
                    lastDate: DateTime.now(),
                  );
                  setState(() {
                    birthdayCtl.text = DateFormat("dd MMMM yyyy").format(date!);
                    birthdatePet = DateFormat("yyyy-MM-dd").format(date);
                  });
                },
                isReadOnly: true,
                label: 'My birthday',
                hintText: 'choose a date',
                controller: birthdayCtl,
                suffixIcon: Icon(
                  Icons.calendar_month,
                  color: const Color(0xffCC5946),
                  size: deviceWidth / 15,
                ),
              ),
              const SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My gender",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: deviceWidth / 25),
                  ),
                  const SizedBox(height: 5.0),
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harap dipilih";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: const Color(0xffFFC989),
                      filled: true,
                      contentPadding: const EdgeInsets.all(12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: const TextStyle(color: Colors.white),
                    ),
                    hint: Text(
                      "Your pet's gender",
                      style: TextStyle(
                        color: const Color(0xff403D2F).withOpacity(.4),
                      ),
                    ),
                    items: ["Male", "Female"]
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.toString())))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        genderPet = value.toString();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(deviceWidth / 20)),
                child: ElevatedButton(
                  onPressed: () {
                    if (addPetFormKey.currentState!.validate()) {
                      if (imageFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Add yout pet's photo first!")));
                      } else {
                        MyPetController().addMyPet(
                          MyPet(
                            name: nameCtl.text,
                            kind: kindCtl.text,
                            breed: breedCtl.text,
                            color: colorCtl.text,
                            gender: genderPet,
                            userId: 4,
                            birthDay: birthdatePet,
                            photoUrl: File(imageFile!.path),
                          ),
                          context,
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC989),
                    padding: EdgeInsets.symmetric(
                      vertical: deviceWidth / 20,
                      horizontal: deviceWidth / 18,
                    ),
                  ),
                  child: Text(
                    'pawfect!',
                    style: TextStyle(
                      color: const Color(0xFF593B39),
                      fontSize: deviceWidth / 20,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget addPhoto(deviceWidth) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            getPhotoPet();
          },
          child: imageFile == null
              ? Container(
                  width: deviceWidth / 4,
                  height: deviceWidth / 4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: const Color(0xffCC5946),
                        size: deviceWidth / 14,
                      ),
                      Text(
                        "Add Photo",
                        style: TextStyle(
                          color: const Color(0xffCC5946),
                          fontWeight: FontWeight.bold,
                          fontSize: deviceWidth / 27,
                        ),
                      )
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
                    child: Image.file(
                      File(imageFile!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Icon(
            Icons.camera_alt,
            color: const Color(0xffFF9725),
            size: deviceWidth / 14,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  bool? isReadOnly;
  Widget? suffixIcon;
  final String? Function(String?)? validator;
  VoidCallback? onTap;

  MyTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.onTap,
    this.isReadOnly,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: deviceWidth / 25),
        ),
        const SizedBox(height: 5.0),
        TextFormField(
          onTap: onTap,
          readOnly: isReadOnly ?? false,
          controller: controller,
          decoration: InputDecoration(
            fillColor: const Color(0xffFFC989),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color(0xff403D2F).withOpacity(.4),
            ),
            contentPadding: const EdgeInsets.all(12.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: suffixIcon ?? const Icon(null),
            errorStyle: const TextStyle(color: Colors.white),
          ),
          style: TextStyle(fontSize: deviceWidth / 25),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
        )
      ],
    );
  }
}
