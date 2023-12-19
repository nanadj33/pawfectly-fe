import 'package:flutter/material.dart';

Widget buildTagChip(String tag) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
    child: IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFFFFE6BE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          child: Center(
            child: Text(
              tag,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ),
    ),
  );
}
