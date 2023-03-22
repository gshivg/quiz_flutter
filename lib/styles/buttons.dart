// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

SignInProviderButton(VoidCallback onPressed, String image, String title,
        BuildContext context) =>
    ElevatedButton(
        onPressed: onPressed, child: buttonDesign(image, title, context));

buttonDesign(String image, String title, BuildContext context) => Container(
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/$image.png'),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
