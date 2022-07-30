import 'package:circular_pattern/src/circular_pattern_options.dart';
import 'package:circular_pattern/src/helper_functions.dart';
import 'package:circular_pattern/src/pattern_dot.dart';
import 'package:flutter/material.dart';

@immutable
class PatternPainter extends CustomPainter {
  final List<PatternDot> dots;
  final List<int> used;
  final Offset? currentPoint;
  final double relativePadding;
  final double pointRadius;
  final bool showInput;

  final Paint circlePaint;
  final Paint selectedPaint;
  final CircularPatternOptions circularPatternOptions;

  PatternPainter({
    required this.dots,
    required this.used,
    this.currentPoint,
    required this.relativePadding,
    required Color selectedColor,
    required Color notSelectedColor,
    required this.pointRadius,
    required this.showInput,
    required bool fillPoints,
    required this.circularPatternOptions,
  })  : circlePaint = Paint()
          ..color = circularPatternOptions.primaryDotColor
          ..style = PaintingStyle.fill
          ..strokeWidth = 10,
        selectedPaint = Paint()
          ..color = circularPatternOptions.selectedDotColor
          ..style = fillPoints ? PaintingStyle.fill : PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 20;

  @override
  void paint(Canvas canvas, Size size) {
    Offset circlePosition(int n) =>
        calcCirclePosition(n, size, dots.length, pointRadius);

    //draw currentline
    final currentPoint = this.currentPoint;
    if (used.isNotEmpty && currentPoint != null) {
      canvas.drawLine(
        circlePosition(used[used.length - 1]),
        currentPoint,
        selectedPaint,
      );
    }

    //draw input line
    if (showInput) {
      for (int i = 0; i < used.length - 1; ++i) {
        canvas.drawLine(
          circlePosition(used[i]),
          circlePosition(used[i + 1]),
          selectedPaint,
        );
      }

      //draw cirlcles
      for (int i = 0; i < dots.length; ++i) {
        final circlePos = circlePosition(i);
        canvas.drawCircle(
          circlePos,
          pointRadius,
          showInput && used.contains(i) ? selectedPaint : circlePaint,
        );

        drawText(dots[i].value, canvas, pointRadius, circlePos);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void drawText(text, canvas, width, offset) {
    final fontSize = width * 1.2;
    
    final textStyle = circularPatternOptions.primaryTextStyle.copyWith(fontSize: fontSize);
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: fontSize,
      maxWidth: fontSize,
    );
    Offset drawPosition = Offset(offset.dx - textPainter.size.width / 2,
        offset.dy - (textPainter.height / 2));
    textPainter.paint(canvas, drawPosition);
  }
}
