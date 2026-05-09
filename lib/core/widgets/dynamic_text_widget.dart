import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class DynamicTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight inputWeight;
  final Color? color;

  const DynamicTextWidget({
    Key? key,
    required this.text,
    required this.fontSize,
    this.inputWeight =  FontWeight.w100,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: fontSize.w,
          fontWeight: inputWeight,
          color: color,
        ),
      ),
    );
  }
}
