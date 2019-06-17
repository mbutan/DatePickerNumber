import 'dart:async';
import 'package:flutter/material.dart';

import 'date_picker_number_settings.dart';
import 'input_model.dart';

class InputFieldWidget extends StatefulWidget {
  final String initialValue;

  final DatePickerNumberSettings settings;

  final InputFieldType type;

  final int index;

  final bool isFocused;

  final bool isValidated;

  final String hintText;

  final StreamController<StreamInputData> inputStream;

  InputFieldWidget(
    this.initialValue,
    this.settings,
    this.type,
    this.index,
    this.isValidated,
    this.isFocused,
    this.hintText,
    this.inputStream
  );

  @override
  State<StatefulWidget> createState() => _InputFieldState();
}
class _InputFieldState extends State<InputFieldWidget> {

  final textFocus = FocusNode();
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    textController.text = widget.initialValue;
    textController.selection = TextSelection.collapsed(offset: 0);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.isFocused) {
      FocusScope.of(context).requestFocus(textFocus);
    }

    return Center(
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
        ),
        child: TextField(
          autofocus: true,
          controller: textController,
          focusNode: textFocus,
          keyboardType: TextInputType.number,
          maxLength: 1,
          maxLines: 1,
          style: widget.settings.inputStyle,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.next,
          onChanged: (text) {
            widget.inputStream.sink.add(StreamInputData(widget.type, widget.index, text));
          },
          decoration: InputDecoration(
            counterText: '',
            helperText: '',
            hintText: widget.hintText,
            hintStyle: widget.settings.hintStyle,
            errorText: widget.isValidated ? null : '',
            errorBorder: widget.settings.errorBorder,
            enabledBorder: widget.settings.enabledBorder,
            disabledBorder: widget.settings.disabledBorder,
            focusedBorder: widget.settings.focusedBorder,
            focusedErrorBorder: widget.settings.focusedErrorBorder,
          ),
        ),
      ),
    );
  }
}