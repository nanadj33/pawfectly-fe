import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawfectly/constants/my_pet_data.dart';
import 'package:pawfectly/constants/pet_report_data.dart';
import 'package:pawfectly/controllers/my_pet_controller.dart';
import 'package:pawfectly/controllers/pet_report_controller.dart';

class PetFormPage extends StatefulWidget {
  const PetFormPage({super.key});

  @override
  _PetFormPageState createState() => _PetFormPageState();
}

class _PetFormPageState extends State<PetFormPage> {
  String selectedreportType = 'Daily Report'; // Default value
  final List<String> reportType = ['Daily Report', 'Consult Report', 'Vaccine'];
  int selectedPetId = 0; // Default value
  final contentReportCtl = TextEditingController();
  final dateReportCtl = TextEditingController();
  String dateReport = '';
  final addPetReportFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFCF2F1),
      appBar: AppBar(
        backgroundColor: const Color(0xffFCF2F1),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff4C4C4C),
          ),
        ),
        title: Text(
          'Report Pet Form',
          style: TextStyle(
            color: const Color(0xff4C4C4C),
            fontSize: deviceWidth / 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: addPetReportFormKey,
          child: ListView(
            children: [
              Text(
                'Pet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4C4C4C),
                  fontSize: deviceWidth / 25,
                ),
              ),
              FutureBuilder(
                  future: MyPetController.getPet(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      List<MyPet> pets = snapshot.data!;
                      return DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return "Harap dipilih";
                          }
                          return null;
                        },
                        hint: const Text('Choose your Pet'),
                        decoration: InputDecoration(
                          fillColor: const Color(0xffFFFEF8),
                          filled: true,
                          contentPadding: const EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: BorderSide.none,
                          ),
                          errorStyle: const TextStyle(color: Color(0xff4C4C4C)),
                        ),
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            selectedPetId = newValue!;
                          });
                        },
                        onSaved: (newValue) {
                          setState(() {
                            selectedPetId = newValue!;
                          });
                        },
                        items: pets
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.id,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Text("Loading data pet");
                    } else if (snapshot.data!.isEmpty) {
                      return const Text("Pet not found");
                    } else {
                      return const SizedBox();
                    }
                  }),
              SizedBox(
                height: deviceWidth / 20,
              ),
              Text(
                'Report Type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4C4C4C),
                  fontSize: deviceWidth / 25,
                ),
              ),

              DropdownButtonFormField(
                value: selectedreportType,
                validator: (value) {
                  if (value == null) {
                    return "Harap dipilih";
                  }
                  return null;
                },
                isExpanded: true,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedreportType = newValue;
                    });
                  }
                },
                decoration: InputDecoration(
                  fillColor: const Color(0xffFFFEF8),
                  filled: true,
                  contentPadding: const EdgeInsets.all(12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide.none,
                  ),
                  errorStyle: const TextStyle(color: Color(0xff4C4C4C)),
                ),
                items: reportType.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
              ),
              SizedBox(
                height: deviceWidth / 20,
              ),
              Text(
                'Select Date and Time',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4C4C4C),
                  fontSize: deviceWidth / 25,
                ),
              ),
              TextFormField(
                controller: dateReportCtl,
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Harap diisi";
                  }
                  return null;
                },
                onTap: () async {
                  final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (date != null) {
                    // ignore: use_build_context_synchronously
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                        DateTime.now(),
                      ),
                      builder: (BuildContext context, Widget? child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      },
                    );
                    setState(() {
                      dateReportCtl.text =
                          '${DateFormat("dd MMMM yyyy").format(date)} ${DateFormat.Hms().format(DateTime(date.year, date.month, date.day, time!.hour, time.minute))}';
                      dateReport = DateFormat("yyyy-MM-dd kk:mm:ss").format(
                          DateTime(date.year, date.month, date.day, time.hour,
                              time.minute));
                    });
                  }
                },
                decoration: InputDecoration(
                  fillColor: const Color(0xffFFFEF8),
                  filled: true,
                  contentPadding: const EdgeInsets.all(12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide.none,
                  ),
                  errorStyle: const TextStyle(color: Color(0xff4C4C4C)),
                ),
              ),
              SizedBox(
                height: deviceWidth / 20,
              ),
              Text(
                'Content',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4C4C4C),
                  fontSize: deviceWidth / 25,
                ),
              ),
              TextFormField(
                controller: contentReportCtl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Harap diisi";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: const Color(0xffFFFEF8),
                  filled: true,
                  contentPadding: const EdgeInsets.all(12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide.none,
                  ),
                  errorStyle: const TextStyle(color: Color(0xff4C4C4C)),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(
                    deviceWidth / 20,
                  )),
                  child: SizedBox(
                    width: deviceWidth / 3.5,
                    height: deviceWidth / 11,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xffCC5946),
                      ),
                      onPressed: () {
                        if (addPetReportFormKey.currentState!.validate()) {
                          PetReportController().addPetReport(
                            PetReport(
                              id: selectedPetId,
                              content: contentReportCtl.text,
                              report: selectedreportType,
                              dateTime: DateTime.parse(dateReport),
                            ),
                            context,
                          );
                        }
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(
                          color: const Color(0xffFCC576),
                          fontSize: deviceWidth / 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // if (attachments.isNotEmpty)
              //   SizedBox(
              //     height: 100,
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: attachments.length,
              //       itemBuilder: (context, index) {
              //         return Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Image.file(
              //             File(attachments[index]),
              //             width: 100,
              //             height: 100,
              //             fit: BoxFit.cover,
              //           ),
              //         );
              //       },
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
