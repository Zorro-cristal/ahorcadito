import 'package:ahorcadito/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget letra(String caracter, bool oculto) {
  return Container(
    height: 65,
    width: 50,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
        color: AppColor.primaryColorDark,
        borderRadius: BorderRadius.circular(4.0)),
    child: Visibility(
      visible: !oculto,
      child: Text(
        caracter,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40,)
      ),
    ),
  );
}
