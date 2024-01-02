// pet_report.dart
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:pawfectly/constants/my_pet_data.dart';
import 'package:pawfectly/constants/pet_report_data.dart';
import 'package:pawfectly/controllers/my_pet_controller.dart';
import 'package:pawfectly/controllers/pet_report_controller.dart';
import 'package:pawfectly/pages/pet_report_detail.dart';
import 'pet_report_form.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({super.key});

  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  bool isAll = true;
  int selectedIndex = 0;
  String selectedFilter = 'All';
  GroupButtonController filterPetController = GroupButtonController();

  @override
  void initState() {
    super.initState();
    filterPetController.selectIndex(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFCF2F1),
      appBar: AppBar(
        backgroundColor: const Color(0xffFCF2F1),
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xff704520),
            )),
        title: Text(
          'Pet Report',
          style: TextStyle(
            color: const Color(0xff4C4C4C),
            fontSize: deviceWidth / 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          petNameFilter(deviceWidth),
          FutureBuilder(
              future: isAll
                  ? PetReportController.getAllPetReport()
                  : PetReportController.getEachPetReport(selectedFilter),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<PetReport> petReports = snapshot.data!;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: deviceWidth / 15),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: petReports.length,
                      itemBuilder: (context, index) {
                        PetReport pet = petReports[index];
                        return Padding(
                            padding: EdgeInsets.only(
                              left: deviceWidth / 20,
                              right: deviceWidth / 20,
                              bottom: deviceWidth / 20,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PetReportDetail(
                                      petReport: PetReport(
                                          id: pet.id,
                                          content: pet.content,
                                          report: pet.report,
                                          dateTime: pet.dateTime));
                                }));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(deviceWidth / 40)),
                                  color: index % 2 == 0
                                      ? const Color(0xffEF8675)
                                      : const Color(0xffCC5946),
                                ),
                                padding: EdgeInsets.all(deviceWidth / 20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            pet.report,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: deviceWidth / 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: deviceWidth / 35,
                                      ),
                                      Text(
                                        pet.content,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: deviceWidth / 27,
                                        ),
                                      ),
                                      SizedBox(
                                        height: deviceWidth / 35,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            DateFormat('dd/MM/yy')
                                                .format(pet.dateTime),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: deviceWidth / 35,
                                            ),
                                          ),
                                          SizedBox(
                                            width: deviceWidth / 35,
                                          ),
                                          Text(
                                            DateFormat('kk:mm')
                                                .format(pet.dateTime),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: deviceWidth / 35,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ));
                      },
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(child: Text("Pet report not found"));
                } else {
                  return const SizedBox();
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PetFormPage(),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        backgroundColor: const Color(0xff704520),
        child: const Icon(Icons.edit),
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
                  elevation: 0,
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
                if (selectedIndex == 0) {
                  isAll = true;
                  selectedFilter = 'All';
                } else if (selectedIndex != 0) {
                  isAll = false;
                  selectedFilter = pets[index - 1].id.toString();
                }
              },
              buttons: [
                "All",
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
}
