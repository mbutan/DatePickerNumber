import 'package:flutter/material.dart';

import 'package:date_picker_number/date_picker_number.dart';
import 'package:date_picker_number/date_picker_number_settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Date Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage('Flutter Date Picker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: DatePickerNumber(
          DatePickerNumberSettings(
            initialDay: 25,
            initialMonth: 11,
            initialYear: 2019,
            dayHeaderText: 'Day',
            monthHeaderText: 'Month',
            yearHeaderText: 'Year',
            hintDay: 'D',
            hintMonth: 'M',
            hintYear: 'Y',
            errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            errorTextStyle: const TextStyle(color: Colors.red),
            headerTextStyle: const TextStyle(color: Colors.grey),
            inputStyle: const TextStyle(color: Colors.black),
            hintStyle: const TextStyle(color: Colors.grey),
            inputFieldPadding: const EdgeInsets.all(5),
            inputFieldWidth: 22,
          ),
          (day) {
            return day > 0 && day < 32 ? null : 'The Day does not match a Date Format.';
          },
          (month) {
            return month > 0 && month < 13 ? null : 'The Month does not match a Date Format.';
          },
          (year) {
            return year > 1900 && year < 2019 ? null : 'The year does not match a Date Format.';
          },
          (day, month, year) {
            DateTime dateTime = DateTime.utc(year, month, day);
            print('generated date time $dateTime');
          }
        ),
      ),
    );
  }
}
