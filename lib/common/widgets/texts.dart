import 'package:flutter/material.dart';

Widget mediumText(String txt, {double fontSize = 16, Color color = Colors.white}){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color
    ),
  );
}
Widget semiBoldText(String txt, {double fontSize = 16, Color color = Colors.white}){
  return Text(
    txt,
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
    style: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
    ),
  );
}
Widget boldText(String txt, {double fontSize = 16, Color color = Colors.white}){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: color
    ),
  );
}

Widget tabBarText(String txt, {double fontSize = 16}){
  return Text(
    txt,
    style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
    ),
  );
}
