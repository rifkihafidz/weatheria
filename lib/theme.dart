import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color lightColor = Color(0xff94B3FD);
Color darkColor = Color(0xff316B83);
Color whiteColor = Colors.white;
Color purpleColor = Color(0xff763857);
Color greyColor = Color(0xff6D8299);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: whiteColor,
);

TextStyle greyTextStyle = GoogleFonts.poppins(
  color: greyColor,
);

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
