import 'package:flutter/material.dart';

Column buildAuthTextFields({
  required String label,
  required TextEditingController controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black))),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: label),
        ),
      )
    ],
  );
}
