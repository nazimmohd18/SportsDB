import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

TextStyle kButtonTextStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18
);
Widget kArrowRight =  SvgPicture.asset(
  "assets/images/arrow_right.svg",
  width: 30,
);


ShapeBorder kTileShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(8)
);