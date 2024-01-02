import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawfectly/pages/signin.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_currentPage < 1) {
        _currentPage++;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xffFCF2F1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFCF2F1),
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/logopaw.svg",
                width: 45,
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                "assets/pawfectly.svg",
                width: 140,
              )
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                SvgPicture.asset("assets/hipal.svg", width: 280),
                const Text(
                  "hi pal.",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffCC5946),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "welcome to PawFectly, where we help you keep your pets PawFectly healthy and happy. Let’s start this pawsome journey!",
                    style: TextStyle(
                      color: Color(0xffCC5946),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                SvgPicture.asset("assets/hihuman.svg",
                    width: MediaQuery.of(context).size.width),
                const Text(
                  "hi human.",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffCC5946),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "here you can engage in lively discussions with fellow pet enthusiasts, seek expert advice online, discover the nearest veterinary clinics, and track the delightful journey of your pet's growth.",
                    style: TextStyle(
                      color: Color(0xffCC5946),
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: InkWell(
          onTap: () {
            if (_currentPage == 0) {
              _pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xffCC5946),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _currentPage == 0 ? "woof!" : "meow!",
                  style: const TextStyle(
                      color: Color.fromARGB(130, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
