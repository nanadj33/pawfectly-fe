import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawfectly/constants/pet_report_data.dart';

class PetReportDetail extends StatelessWidget {
  final PetReport petReport;
  const PetReportDetail({super.key, required this.petReport});

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
          petReport.report,
          style: TextStyle(
            color: const Color(0xff4C4C4C),
            fontSize: deviceWidth / 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth / 20),
            child: Text(
              '${DateFormat('MMMM dd, yyyy').format(petReport.dateTime)}  |  ${DateFormat('kk:mm').format(petReport.dateTime)}',
              style: TextStyle(
                fontSize: deviceWidth / 30,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(deviceWidth / 20),
            child: Container(
              padding: EdgeInsets.all(deviceWidth / 20),
              decoration: const BoxDecoration(color: Colors.white),
              child: Text(
                petReport.content,
                style: TextStyle(
                  fontSize: deviceWidth / 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
