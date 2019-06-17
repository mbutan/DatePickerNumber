import 'dart:async';

import 'package:flutter/material.dart';

import 'date_picker_number_settings.dart';
import 'input_section_widget.dart';
import 'input_field_widget.dart';
import 'input_model.dart';

class DatePickerNumber extends StatefulWidget {
  final DatePickerNumberSettings settings;

  final String Function(int) dayValidator;

  final String Function(int) monthValidator;

  final String Function(int) yearValidator;

  final String Function(int day, int month, int year) onDateCallback;

  DatePickerNumber(this.settings, this.dayValidator, this.monthValidator, this.yearValidator, this.onDateCallback);

  @override
  State<StatefulWidget> createState() => _DatePickerNumberState();
}

class _DatePickerNumberState extends State<DatePickerNumber> {

  _ViewModel _viewModel;

  final StreamController<StreamInputData> _inputStream = StreamController();

  _handleInputStream() {
    _inputStream.stream.listen((data) {
      // Do nothing on delete action.
      if (data.text != '') {
        // Re draw sections
        setState(() {
          _viewModel.appendValue(data.type, data.text, data.index);

          int day = _viewModel.day();
          int month = _viewModel.month();
          int year = _viewModel.year();
          if (day != null && month != null && year != null) {
            widget.onDateCallback(day, month, year);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _viewModel = _ViewModel(
      widget.settings.initialDay,
      widget.settings.initialMonth,
      widget.settings.initialYear,
    );

    _handleInputStream();
  }

  @override
  void dispose() {
    super.dispose();

    _inputStream.close();
  }

  @override
  Widget build(BuildContext context) {
    String dayValidated = _viewModel.isDayValidated(widget.dayValidator);
    String monthValidated = _viewModel.isMonthValidated(widget.monthValidator);
    String yearValidated = _viewModel.isYearValidated(widget.yearValidator);

    bool isDayValidated = dayValidated == null;
    bool isMonthValidated = monthValidated == null;
    bool isYearValidated = yearValidated == null;

    String errorMessage = dayValidated ?? monthValidated ?? yearValidated ?? '';

    return Column(
      children: <Widget>[

        // Input fields
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: InputSectionWidget(
                widget.settings.dayHeaderText,
                widget.settings.headerTextStyle,
                widget.settings.inputFieldPadding,
                widget.settings.inputFieldWidth,
                [
                  InputFieldWidget(
                    _viewModel.valueFor(InputFieldType.day, 0),
                    widget.settings, InputFieldType.day,
                    0,
                    isDayValidated,
                    _viewModel.isFocusedInput(InputFieldType.day, 0),
                    widget.settings.hintDay,
                    _inputStream
                  ),
                  InputFieldWidget(
                    _viewModel.valueFor(InputFieldType.day, 1),
                    widget.settings, InputFieldType.day,
                    1,
                    isDayValidated,
                    _viewModel.isFocusedInput(InputFieldType.day, 1),
                    widget.settings.hintDay,
                    _inputStream
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: InputSectionWidget(
                widget.settings.monthHeaderText,
                widget.settings.headerTextStyle,
                widget.settings.inputFieldPadding,
                widget.settings.inputFieldWidth,
                [
                  InputFieldWidget(
                    _viewModel.valueFor(InputFieldType.month, 0),
                    widget.settings,
                    InputFieldType.month,
                    0,
                    isMonthValidated,
                    _viewModel.isFocusedInput(InputFieldType.month, 0),
                    widget.settings.hintMonth,
                    _inputStream
                  ),
                  InputFieldWidget(
                    _viewModel.valueFor(InputFieldType.month, 1),
                    widget.settings,
                    InputFieldType.month,
                    1,
                    isMonthValidated,
                    _viewModel.isFocusedInput(InputFieldType.month, 1),
                    widget.settings.hintMonth,
                    _inputStream
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: InputSectionWidget(
                widget.settings.yearHeaderText,
                widget.settings.headerTextStyle,
                widget.settings.inputFieldPadding,
                widget.settings.inputFieldWidth,
                [
                  InputFieldWidget(
                    _viewModel.valueFor(InputFieldType.year, 0),
                    widget.settings,
                    InputFieldType.year,
                    0,
                    isYearValidated,_viewModel.isFocusedInput(InputFieldType.year, 0),
                    widget.settings.hintYear,
                    _inputStream
                  ),
                  InputFieldWidget(
                    _viewModel.valueFor(InputFieldType.year, 1),
                    widget.settings,
                    InputFieldType.year,
                    1,
                    isYearValidated,_viewModel.isFocusedInput(InputFieldType.year, 1),
                    widget.settings.hintYear,
                    _inputStream
                  ),
                  InputFieldWidget(
                    _viewModel.valueFor(InputFieldType.year, 2),
                    widget.settings,
                    InputFieldType.year,
                    2,
                    isYearValidated,_viewModel.isFocusedInput(InputFieldType.year, 2),
                    widget.settings.hintYear,
                    _inputStream
                  ),
                  InputFieldWidget(
                    _viewModel.valueFor(InputFieldType.year, 3),
                    widget.settings,
                    InputFieldType.year,
                    3,
                    isYearValidated,_viewModel.isFocusedInput(InputFieldType.year, 3),
                    widget.settings.hintYear,
                    _inputStream
                  ),
                ],
              ),
            ),
          ],
        ),

        // Error message
        Text(
          errorMessage,
          style: widget.settings.errorTextStyle,
        ),
      ],
    );
  }
}

class _ViewModel {
  List<int> _day = List(2);

  List<int> _month = List.filled(2, null);

  List<int> _year = List(4);

  StreamFocusInput _focusedInput = StreamFocusInput(InputFieldType.day, 0);

  _ViewModel(int day, int month, int year):
    this._day = _convertNumberToList(day, 2),
    this._month = _convertNumberToList(month, 2),
    this._year = _convertNumberToList(year, 4);


  int day() => _validatedList(_day) ? _convertListToNumber(_day) : null;

  int month() => _validatedList(_month) ? _convertListToNumber(_month) : null;

  int year() => _validatedList(_year) ? _convertListToNumber(_year) : null;

  bool isFocusedInput(InputFieldType type, int index) => type == _focusedInput.type && index == _focusedInput.index;

  String isDayValidated(String Function(int) validator) => isListValidated(validator, _day);

  String isMonthValidated(String Function(int) validator) => isListValidated(validator, _month);

  String isYearValidated(String Function(int) validator) => isListValidated(validator, _year);

  String isListValidated(String Function(int) validator, List<int> list) {
    if (_validatedList(list)) {
      // Once the list has been fulfilled.
      int number = _convertListToNumber(list);
      return validator(number);
    } else {
      return null;
    }
  }

  appendValue(InputFieldType type, String value, int index) {
    int newValue = value == '' ? null : int.parse(value);
    if (type == InputFieldType.day) {
      _appendDay(newValue, index);
    } else if (type == InputFieldType.month) {
      _appendMonth(newValue, index);
    } else if (type == InputFieldType.year) {
      _appendYear(newValue, index);
    }

    _focusNextInput(type, index);
  }

  String valueFor(InputFieldType type, int atIndex) {
    int number;
    if (type == InputFieldType.day) {
      number = _day.length > atIndex ? _day[atIndex] : null;
    } else if (type == InputFieldType.month) {
      number = _month.length > atIndex ? _month[atIndex] : null;
    } else if (type == InputFieldType.year) {
      number = _year.length > atIndex ? _year[atIndex] : null;
    }
    return number == null ? '' : number.toString();
  }

  _focusNextInput(InputFieldType type, int index) {
    if (type == InputFieldType.day && index == 0) {
      _focusedInput = StreamFocusInput(InputFieldType.day, 1);
    } else if (type == InputFieldType.day && index == 1) {
      _focusedInput = StreamFocusInput(InputFieldType.month, 0);
    } else if (type == InputFieldType.month && index == 0) {
      _focusedInput = StreamFocusInput(InputFieldType.month, 1);
    } else if (type == InputFieldType.month && index == 1) {
      _focusedInput = StreamFocusInput(InputFieldType.year, 0);
    } else if (type == InputFieldType.year && index == 0) {
      _focusedInput = StreamFocusInput(InputFieldType.year, 1);
    } else if (type == InputFieldType.year && index == 1) {
      _focusedInput = StreamFocusInput(InputFieldType.year, 2);
    } else if (type == InputFieldType.year && index == 2) {
      _focusedInput = StreamFocusInput(InputFieldType.year, 3);
    }
  }

  _appendDay(int value, int index) => _day[index] = value;

  _appendMonth(int value, int index) => _month[index] = value;

  _appendYear(int value, int index) => _year[index] = value;

  bool _validatedList(List<int> list) {
    for(var i = 0; i<list.length; i++) {
      if (list[i] == null) {
        return false;
      }
    }
    return true;
  }

  int _convertListToNumber(List<int> list) {
    int value = 0;
    for(var i = 0; i<list.length; i++) {
      value = (value * 10) + list[i];
    }
    return value;
  }

  static List<int> _convertNumberToList(int number, int length) {
    if (number == null) {
      return List(length);
    }

    List<int> result = List();
    int index = 0;
    double tmpNumber = number.toDouble();

    while (tmpNumber > 0 && index < length) {
      int newValue = (tmpNumber % 10).toInt();
      result.add(newValue);
      tmpNumber /= 10;
      index ++;
    }

    return result.reversed.toList();
  }
}
