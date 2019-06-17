import 'package:flutter/material.dart';

class FlutterDatePickerNumberSettings {
  // Initial Values
  final int initialDay;

  final int initialMonth;

  final int initialYear;

  // Translations
  final String dayHeaderText;

  final String monthHeaderText;

  final String yearHeaderText;

  // Decoration
  final InputBorder errorBorder;

  final InputBorder enabledBorder;

  final InputBorder disabledBorder;

  final InputBorder focusedBorder;

  final InputBorder focusedErrorBorder;

  // Style
  final EdgeInsetsGeometry inputFieldPadding;

  final TextStyle errorTextStyle;

  final TextStyle headerTextStyle;

  final TextStyle inputStyle;

  final double inputFieldWidth;

  const FlutterDatePickerNumberSettings({
    this.initialDay,
    this.initialMonth,
    this.initialYear,
    this.dayHeaderText,
    this.monthHeaderText,
    this.yearHeaderText,
    this.errorBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    this.enabledBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    this.disabledBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
    this.focusedBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    this.focusedErrorBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    this.errorTextStyle = const TextStyle(color: Colors.red),
    this.headerTextStyle = const TextStyle(color: Colors.grey),
    this.inputStyle = const TextStyle(color: Colors.black),
    this.inputFieldPadding = const EdgeInsets.all(5),
    this.inputFieldWidth = 30,
  });
}