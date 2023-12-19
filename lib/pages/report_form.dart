// report_form.dart
import 'dart:io';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pawfectly/pages/pet_report.dart';

class PetFormPage extends StatefulWidget {
  @override
  _PetFormPageState createState() => _PetFormPageState();
}

class _PetFormPageState extends State<PetFormPage> {
  String selectedreportType = 'Daily Report'; // Default value
  final List<String> reportType = ['Daily Report', 'Consultation', 'Vaccine'];
  String selectedPetName = 'Molly'; // Default value
  final List<String> petNames = ['Molly', 'Corgi', 'Mushroom', 'Snowy'];

  String content = '';
  List<String> attachments = [];
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCF2F1),
      appBar: AppBar(
        backgroundColor: Color(0xffFCF2F1),
        title: Text('Report Pet Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedPetName,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedPetName = newValue;
                  });
                }
              },
              items: petNames.map((String name) {
                return DropdownMenuItem<String>(
                  value: name,
                  child: Text(name),
                );
              }).toList(),
            ),

            DropdownButton<String>(
              value: selectedreportType,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedreportType = newValue;
                  });
                }
              },
              items: reportType.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),

            DateTimeField(
              decoration: InputDecoration(labelText: 'Select Date and Time'),
              format: DateFormat("yyyy-MM-dd HH:mm"),
              onShowPicker: (context, currentValue) async {
                final DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: currentValue ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (date != null) {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  if (time != null) {
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                } else {
                  return currentValue;
                }
              },
              onChanged: (dateTime) {
                setState(() {
                  selectedDateTime = dateTime;
                });
              },
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  content = value;
                });
              },
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  Pet(
                    name: selectedPetName,
                    content: content,
                    report: selectedreportType,
                    dateTime: selectedDateTime ?? DateTime.now(),
                  ),
                );
              },
              child: Text('Submit Report'),
            ),

            SizedBox(height: 8),
            if (attachments.isNotEmpty)
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: attachments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(attachments[index]),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
