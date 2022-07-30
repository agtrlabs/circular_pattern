import 'package:flutter/painting.dart';

class CircularPatternOptions {
  final Color selectedDotColor;
  final Color primaryDotColor;
  final TextStyle primaryTextStyle;
  final TextStyle selectedTextStyle;

  const CircularPatternOptions({
    this.primaryTextStyle = const TextStyle(
      color: Color.fromARGB(255, 9, 31, 58),
    ),
    this.selectedTextStyle = const TextStyle(
      color: Color.fromARGB(255, 24, 45, 78),
    ),
    this.selectedDotColor = const Color.fromARGB(255, 88, 155, 237),
    this.primaryDotColor = const Color.fromARGB(255, 193, 215, 223),
  });
}
