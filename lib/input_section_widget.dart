import 'package:flutter/material.dart';

import 'input_field_widget.dart';

class InputSectionWidget extends StatelessWidget {
  final String header;

  final TextStyle headerStyle;

  final EdgeInsetsGeometry inputFieldPadding;

  final double inputFieldWidth;

  final List<InputFieldWidget> inputs;

  InputSectionWidget(
    this.header,
    this.headerStyle,
    this.inputFieldPadding,
    this.inputFieldWidth,
    this.inputs
  );

  _generateHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        header,
        style: headerStyle,
        textAlign: TextAlign.left,
      ),
    );
  }

  _generateInputFields() {
    return Row(children: this.inputs
      .map((input) {{}
        return Container(
          padding: inputFieldPadding,
          width: inputFieldWidth,
          child: input,
        );
      })
      .toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        // Header.
        _generateHeader(),

        // Input fields.
        _generateInputFields(),
      ],
    );
  }
}