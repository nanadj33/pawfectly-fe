import 'package:flutter/material.dart';
import 'package:pawfectly/constants/clinic_data.dart';

class ClinicFinder extends StatefulWidget {
  const ClinicFinder({super.key});

  @override
  State<ClinicFinder> createState() => _ClinicFinderState();
}

class _ClinicFinderState extends State<ClinicFinder> {
  List<ClinicCardInfo> allClinics = [];
  List<ClinicCardInfo> displayedClinics = [];
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _getInitialInfo();
    _searchController.addListener(_onSearchChanged);
  }

  void _getInitialInfo() {
    allClinics = ClinicCardInfo.getClinic();
    displayedClinics = List.from(allClinics);
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      displayedClinics = allClinics
          .where((clinic) =>
              clinic.name.toLowerCase().contains(query) ||
              clinic.services.toLowerCase().contains(query) ||
              clinic.alamat.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCF2F1),
      appBar: AppBar(
        backgroundColor: Color(0xffFCF2F1),
        leading: Icon(Icons.arrow_back),
        title: Text("Clinic Finder"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Search for District or City",
                  hintStyle: TextStyle(color: Color(0xffBF9089)),
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(Icons.search, color: Color(0xffBF9089)),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0,
                childAspectRatio: 2,
              ),
              itemCount: displayedClinics.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: ClinicCard(displayedClinics[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ClinicCard extends StatelessWidget {
  final ClinicCardInfo clinicInfo;

  ClinicCard(this.clinicInfo);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffFCF2F1),
      child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clinicInfo.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    height: 1
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  clinicInfo.services,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Text(
                  clinicInfo.alamat,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    height: 1

                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${clinicInfo.rating}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      )
                    ),
                    Text(
                      "${clinicInfo.distance} mi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                      
                    ),
                    
                  ],
                ),
                
                
              ],
            ),
          ),
    );
  }
}
