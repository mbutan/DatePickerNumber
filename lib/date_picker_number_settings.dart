import 'package:flutter/material.dart';

class DatePickerNumberSettings {
  final bool isFocusKeyboard;

  // Initial Values
  final int initialDay;

  final int initialMonth;

  final int initialYear;

  final String hintDay;

  final String hintMonth;

  final String hintYear;

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

  final TextStyle hintStyle;

  final double inputFieldWidth;

  const DatePickerNumberSettings({
    this.isFocusKeyboard = true,
    this.initialDay,
    this.initialMonth,
    this.initialYear,
    this.hintDay = 'D',
    this.hintMonth = 'M',
    this.hintYear = 'Y',
    this.dayHeaderText = 'Day',
    this.monthHeaderText = 'Month',
    this.yearHeaderText = 'Year',
    this.errorBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    this.enabledBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    this.disabledBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
    this.focusedBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    this.focusedErrorBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    this.errorTextStyle = const TextStyle(color: Colors.red),
    this.headerTextStyle = const TextStyle(color: Colors.grey),
    this.inputStyle = const TextStyle(color: Colors.black),
    this.hintStyle = const TextStyle(color: Colors.grey),
    this.inputFieldPadding = const EdgeInsets.all(5),
    this.inputFieldWidth = 22,
  });
}