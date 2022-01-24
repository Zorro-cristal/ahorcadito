import 'package:flutter/material.dart';

Widget figuraImage(bool visible, String path) {
  return Visibility(
    visible: visible,
    child: Container(
      width: 250,
      height: 250,
      child: Image.asset(path)
    ),
  );
}