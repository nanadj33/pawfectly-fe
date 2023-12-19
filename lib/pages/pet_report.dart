// pet_report.dart
import 'package:flutter/material.dart';
import 'report_form.dart';

class Pet {
  String name;
  String content; // Ganti breed menjadi content
  String report;
  DateTime dateTime;
  List<String> attachments;

  Pet({
    required this.name,
    required this.content,
    required this.report,
    required this.dateTime,
    required this.attachments,
  });
}

class PetListPage extends StatefulWidget {
  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  List<Pet> reportedPets = [];
  List<String> filterOptions = ['All', 'Molly', 'Corgi', 'Mushroom'];
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reported Pets'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: filterOptions.map((String option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedFilter = option;
                      });
                    },
                    child: Chip(
                      label: Text(option),
                      backgroundColor: selectedFilter == option ? Colors.blue : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reportedPets.length,
              itemBuilder: (context, index) {
                Pet pet = reportedPets[index];

                if (selectedFilter == 'All' || pet.name.toLowerCase() == selectedFilter.toLowerCase()) {
                  return ListTile(
                    title: Text('Pet Name: ${pet.name}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Content: ${pet.content}'),
                        Text('Report: ${pet.report}'),
                        Text('Date and Time: ${pet.dateTime}'),
                        Text('Attachments: ${pet.attachments.join(", ")}'),
                      ],
                    ),
                  );
                } else {
                  return Container(); // Return an empty container for non-matching items
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPet = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetFormPage(),
            ),
          );

          if (newPet != null) {
            setState(() {
              reportedPets.add(newPet as Pet);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
