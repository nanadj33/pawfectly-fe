import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildInfoContainer(String iconPath, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(0xffFCC576),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 30,
                  color: Color(0xffCC5946),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 16, color: Color(0xffCC5946), fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            SvgPicture.asset(
              "assets/pen.svg",
              width: 24,
            )
          ],
        ),
      ),
    );
  }