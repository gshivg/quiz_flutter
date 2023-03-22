// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

ImageButton(VoidCallback onPressed, String image, String title,
        BuildContext context) =>
    ElevatedButton(
      onPressed: onPressed,
      child: imageButtonDesign(image, title, context),
      style: ButtonStyle(elevation: MaterialStateProperty.all(15)),
    );

PrimaryButton(VoidCallback onPressed, String title, BuildContext context) =>
    Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: Theme.of(context).textTheme.headlineSmall!.color!,
          ),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: primaryButtonDesign(title, context),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(15),
          ),
        ),
      ),
    );

primaryButtonDesign(String title, BuildContext context) => Container(
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(width: 20),
        ],
      ),
    );

imageButtonDesign(String image, String title, BuildContext context) =>
    Container(
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
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
