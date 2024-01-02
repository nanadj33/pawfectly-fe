import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pawfectly/pages/homePage.dart';
import 'package:pawfectly/pages/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  initializeDateFormatting("id");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pawfectly',
      theme: ThemeData(
        useMaterial3: false,
        textTheme: GoogleFonts.mPlusRounded1cTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        body: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, prefs) {
              var dataPrefs = prefs.data;
              if (prefs.hasData) {
                if (dataPrefs!.getString('id') != null) {
                  return const HomePage();
                } else {
                  return const OnboardingPage();
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ); // Login Page
              }
            }),
      ),
    );
  }
}
