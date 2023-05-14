// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

primaryTextField(
  TextEditingController textEditingController,
  BuildContext context,
  String labelText,
  IconData icon, {
  bool isPassword = false,
  TextInputType keyboardType = TextInputType.text,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          label: displayLabel(labelText, icon),
        ),
        obscuringCharacter: '*',
        obscureText: isPassword,
        controller: textEditingController,
        keyboardType: keyboardType,
      ),
    );

displayLabel(String labelText, IconData iconData) => Row(
      children: [
        Icon(iconData),
        const SizedBox(width: 10),
        Text(labelText),
      ],
    );
