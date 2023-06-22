import 'package:flutter/material.dart';

buildGenericTextfield(
    {required String hint,
    required TextEditingController controller,
    required void Function(String) onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(hint),
      Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(left: 20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
          ),
          onChanged: onChanged,
        ),
      ),
    ],
  );
}
