import 'package:flutter/material.dart';

Widget buildAttachmentChip(String attachment, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
    child: GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Image.asset(
                attachment,
                fit: BoxFit.contain,
              ),
            );
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          attachment,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    )
  );
}
