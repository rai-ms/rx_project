import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  final TextAlign textAlign;

  const SectionTitle({
    super.key,
    required this.title,
    this.padding,
    this.color = Colors.white,
    this.fontSize = 22.0,
    this.fontWeight = FontWeight.bold,
    this.letterSpacing = -0.015,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 20, bottom: 12, left: 4, right: 4),
      child: Text(
        title,
        textAlign: textAlign,
        style: GoogleFonts.workSans(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}
