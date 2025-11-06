import 'package:flutter/material.dart';

class CustomTitleText extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double letterSpacing;
  final Color? color;

  const CustomTitleText({
    Key? key,
    required this.title,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w700,
    this.textAlign = TextAlign.center,
    this.letterSpacing = 0.2,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Colors.black,
        letterSpacing: letterSpacing,
        height: 1.3,
      ),
    );
  }
}
