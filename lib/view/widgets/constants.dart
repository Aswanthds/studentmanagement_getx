import 'package:flutter/material.dart';

Widget changeStyle(String title, String value) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(color: Colors.black), //apply style to all
      children: [
        TextSpan(
            text: '$title : ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        TextSpan(text: value, style: const TextStyle(fontSize: 25)),
      ],
    ),
  );
}
