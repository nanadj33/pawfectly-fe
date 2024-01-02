import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:pawfectly/constants/constants.dart';
import 'package:pawfectly/constants/my_pet_data.dart';
import 'package:pawfectly/controllers/my_pet_controller.dart';
import 'package:pawfectly/pages/my_pet_update.dart';

class MyPetAll extends StatefulWidget {
  const MyPetAll({super.key});

  @override
  State<MyPetAll> createState() => _MyPetStateAll();
}

class _MyPetStateAll extends State<MyPetAll> {
  int selectedIndex = 0;

  String genderPet = '';
  String birthdatePet = '';
  final addPetFormKey = GlobalKey<FormState>();

  GroupButtonController filterPetController = GroupButtonController();

  @override
  void initState() {
    super.initState();
    filterPetController.selectIndex(0);
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
          petNameFilter(deviceWidth),
          dataPetForm(deviceWidth),
        ],
      ),
    );
  }

  Widget petNameFilter(deviceWidth) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder(
        future: MyPetController.getPet(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<MyPet> pets = snapshot.data!;

            return GroupButton(
              controller: filterPetController,
              options: GroupButtonOptions(
                  selectedColor: const Color(0xffFF9725),
                  groupingType: GroupingType.row,
                  unselectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  borderRadius: BorderRadius.circular(deviceWidth / 50),
                  unselectedColor: const Color(0xffFFC989).withOpacity(.6)),
              isRadio: true,
              onSelected: (value, index, isSelected) {
                setState(() {
                  selectedIndex = index;
                });
              },
              buttons: [
                for (int i = 0; i < pets.length; i++) pets[i].name,
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget dataPetForm(deviceWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth / 20),
      child: FutureBuilder(
          future: MyPetController.getPet(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<MyPet> pets = snapshot.data!;
              final nameCtl =
                  TextEditingController(text: pets[selectedIndex].name);
              final kindCtl =
                  TextEditingController(text: pets[selectedIndex].kind);
              final breedCtl =
                  TextEditingController(text: pets[selectedIndex].breed);
              final colorCtl =
                  TextEditingController(text: pets[selectedIndex].color);
              final birthdayCtl = TextEditingController(
                  text: DateFormat('dd MMMM yyyy')
                      .format(DateTime.parse(pets[selectedIndex].birthDay)));
              return Form(
                  key: addPetFormKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: deviceWidth / 10,
                      ),
                      Stack(
                        children: [
                          pets[selectedIndex].imagePath == null
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
                                        Icons.pets,
                                        color: const Color(0xffCC5946),
                                        size: deviceWidth / 14,
                                      ),
                                      Text(
                                        "No Photo",
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
                                    child: Image.network(
                                      "$urlIp${pets[selectedIndex].imagePath!}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: deviceWidth / 15,
                      ),
                      MyTextField(
                        label: 'my name is...',
                        hintText: "Your pet's name",
                        controller: nameCtl,
                      ),
                      const SizedBox(height: 10.0),
                      MyTextField(
                        label: "I'm a...",
                        hintText: 'e.g: Cat',
                        controller: kindCtl,
                      ),
                      const SizedBox(height: 10.0),
                      MyTextField(
                        label: "specifically, I'm a",
                        hintText: 'Breed, e.g: Perssian',
                        controller: breedCtl,
                      ),
                      const SizedBox(height: 10.0),
                      MyTextField(
                        label: "My color",
                        hintText: 'e.g: Black',
                        controller: colorCtl,
                      ),
                      const SizedBox(height: 10.0),
                      MyTextField(
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
                            value: pets[selectedIndex].gender,
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
                            onChanged: null,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(deviceWidth / 20)),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MyPetUpdate(
                                  myPet: MyPet(
                                id: pets[selectedIndex].id,
                                name: pets[selectedIndex].name,
                                kind: pets[selectedIndex].kind,
                                breed: pets[selectedIndex].breed,
                                color: pets[selectedIndex].color,
                                gender: pets[selectedIndex].gender,
                                userId: pets[selectedIndex].userId,
                                birthDay: pets[selectedIndex].birthDay,
                                photoUrl: null,
                                imagePath: pets[selectedIndex].imagePath,
                              ));
                            })).then((_) {
                              setState(() {});
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFC989),
                            padding: EdgeInsets.symmetric(
                              vertical: deviceWidth / 20,
                              horizontal: deviceWidth / 18,
                            ),
                          ),
                          child: Text(
                            'update data',
                            style: TextStyle(
                              color: const Color(0xFF593B39),
                              fontSize: deviceWidth / 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: deviceWidth / 20),
                    ],
                  ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
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
          enabled: false,
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
        )
      ],
    );
  }
}
