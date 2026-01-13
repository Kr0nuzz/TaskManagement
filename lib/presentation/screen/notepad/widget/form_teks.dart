import 'package:flutter/material.dart';

class FormTeks extends StatelessWidget {
  final TextEditingController formcontroller;
  final String hintText;
  final int? maxLines;
  final TextInputType keyboardType;
  final double fontSize;

  const FormTeks({
    super.key,
    required this.formcontroller,
    required this.hintText,
    this.maxLines,
    required this.keyboardType,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return TextField(
          controller: formcontroller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(
              fontSize: fontSize,
              color: Theme.of(context).appBarTheme.titleTextStyle?.color),
          decoration: InputDecoration(
              fillColor: Theme.of(context).canvasColor,
              hintText: hintText,
              hintStyle: TextStyle(
                  color: Theme.of(context).inputDecorationTheme.fillColor),
              border: InputBorder.none));
    });
  }
}
