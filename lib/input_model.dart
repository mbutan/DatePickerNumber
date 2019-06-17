enum InputFieldType {
  day,
  month,
  year,
}

class StreamInputData {
  final InputFieldType type;
  final int index;
  final String text;

  StreamInputData(this.type, this.index, this.text);
}

class StreamFocusInput {
  final InputFieldType type;
  final int index;

  StreamFocusInput(this.type, this.index);
}