// pet_report.dart
import 'package:flutter/material.dart';
import 'report_form.dart';

class Pet {
  String name;
  String content;
  String report;
  DateTime dateTime;

  Pet({
    required this.name,
    required this.content,
    required this.report,
    required this.dateTime,
  });
}

class PetListPage extends StatefulWidget {
  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  List<Pet> reportedPets = [];
  List<String> filterOptions = ['All', 'Molly', 'Corgi', 'Mushroom', 'Snowy'];
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCF2F1),
      appBar: AppBar(
        backgroundColor: Color(0xffFCF2F1),
        leading: Icon(Icons.arrow_back),
        title: Text('Reported Pets'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
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
                              backgroundColor: selectedFilter == option
                                  ? Colors.orange
                                  : Colors.orange[200],
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: reportedPets.length,
              itemBuilder: (context, index) {
                Pet pet = reportedPets[index];

                if (selectedFilter == 'All' ||
                    pet.name.toLowerCase() == selectedFilter.toLowerCase()) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            16.0), // Sesuaikan nilai ini sesuai keinginan
                    child: Theme(
                      data: ThemeData(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: ListTileTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          tileColor: Colors.red[100],
                          title: Text('Pet Name: ${pet.name}',
                              style: TextStyle(color: Colors.grey[700])),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Content: ${pet.content}',
                                  style: TextStyle(color: Colors.grey[700])),
                              Text('Report: ${pet.report}',
                                  style: TextStyle(color: Colors.grey[700])),
                              Text('Date and Time: ${pet.dateTime}',
                                  style: TextStyle(color: Colors.grey[700])),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
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
        backgroundColor: Colors.brown,
        child: Icon(Icons.add),
      ),
    );
  }
}
