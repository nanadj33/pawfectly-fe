import 'package:flutter/material.dart';

class TagFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
          child: TextFormField(
            maxLines: 1,
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
