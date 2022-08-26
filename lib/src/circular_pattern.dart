import 'package:circular_pattern/src/circular_pattern_options.dart';
import 'package:circular_pattern/src/helper_functions.dart';
import 'package:circular_pattern/src/pattern_dot.dart';
import 'package:circular_pattern/src/pattern_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircularPattern extends StatefulWidget {
  // onStart callback function is called when user starts to draw a new pattern
  final Function()? onStart;

  /// onComplete function is called when user selected at least [minInputLength] of points.
  final Function(List<PatternDot> input) onComplete;

  // minimum acceptable input length
  final int minInputLength = 3;

  final List<PatternDot> dots;
  final CircularPatternOptions options;
  const CircularPattern({
    Key? key,
    this.onStart,
    this.options = const CircularPatternOptions(),
    this.dots = const [
      PatternDot(value: '1'),
      PatternDot(value: '2'),
      PatternDot(value: '3')
    ],
    required this.onComplete,
  }) : super(key: key);

  @override
  _CircularPatternState createState() => _CircularPatternState();
}

class _CircularPatternState extends State<CircularPattern> {
  List<int> used = [];
  Offset? currentPoint;
  bool started = false;
  double pointRadius = 30;
  void startInput() {
    // onStart
    if (!started) {
      started = true;
      widget.onStart?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        //RenderBox referenceBox = context.findRenderObject() as RenderBox;

        pointRadius =
            constraints.biggest.shortestSide / (widget.dots.length + 1);
        return GestureDetector(
          onPanEnd: (DragEndDetails details) {
            if (used.isNotEmpty) {
              List<PatternDot> result = [];
              for (var element in used) {
                result.add(widget.dots[element]);
              }
              if (result.length >= widget.minInputLength) {
                widget.onComplete(result);
              }
            }
            //end of input
            setState(() {
              used = [];
              currentPoint = null;
              started = false;
            });
          },
          onPanUpdate: (DragUpdateDetails details) {
            RenderBox referenceBox = context.findRenderObject() as RenderBox;
            Offset localPosition =
                referenceBox.globalToLocal(details.globalPosition);

            Offset circlePosition(int n) => calcCirclePosition(
                n, referenceBox.size, widget.dots.length, pointRadius);
            for (int i = 0; i < widget.dots.length; ++i) {
              final toPoint = (circlePosition(i) - localPosition).distance;
              if (!used.contains(i) && toPoint < pointRadius) {
                used.add(i);
                startInput();
              }
            }
            setState(() {
              currentPoint = localPosition;
            });
          },
          child: CustomPaint(
            painter: PatternPainter(
              dots: widget.dots,
              used: used,
              currentPoint: currentPoint,
              relativePadding: -120,
              selectedColor: widget.options.selectedDotColor,
              notSelectedColor: widget.options.primaryDotColor,
              pointRadius: pointRadius,
              showInput: true,
              fillPoints: true,
              circularPatternOptions: widget.options,
            ),
            size: Size.infinite,
          ),
        );
      }),
    );
  }
}
