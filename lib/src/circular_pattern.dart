import 'package:circular_pattern/src/circular_pattern_options.dart';
import 'package:circular_pattern/src/helper_functions.dart';
import 'package:circular_pattern/src/pattern_dot.dart';
import 'package:circular_pattern/src/pattern_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// CircularPatter is the visual widget to be added to the widget tree
/// Widget tries to automatically scale according to its area. 
/// Must define at least 3 PatterDots
class CircularPattern extends StatefulWidget {
  // onStart callback function is called when user starts to draw a new pattern
  final Function()? onStart;

  /// onComplete function is called when user selects at least [minInputLength] of points and releases panning the widget.
  final Function(List<PatternDot> input) onComplete;

  /// onChange function is called when user selects a new point.
  final Function(List<PatternDot> input)? onChange;

  /// minimum acceptable input length
  final int minInputLength;

  final List<PatternDot> dots;

  /// Style options 
  final CircularPatternOptions options;

  /// Radius of the PatternDot Circle
  final double pointRadius;

  const CircularPattern({
    super.key,
    this.dots = const [
      PatternDot(value: '1'),
      PatternDot(value: '2'),
      PatternDot(value: '3')
    ],
    this.minInputLength = 3,
    required this.onComplete,
    this.onChange,
    this.onStart,
    this.options = const CircularPatternOptions(),
    this.pointRadius = 30,
  }): assert(
          dots.length >= 3,
          'Must have At least 3 PatternDots',
        );

  @override
  createState() => _CircularPatternState();
}

class _CircularPatternState extends State<CircularPattern> {
  // index list of used points
  List<int> used = [];

  Offset? currentPoint;
  bool started = false;
  late double pointRadius;
  @override
  Widget build(BuildContext context) {
    pointRadius = widget.pointRadius;
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
                notifyOnChange(used);
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

  void notifyOnChange(List<int> used) {
    List<PatternDot> dotList = [];
    for (var element in used) {
      dotList.add(widget.dots[element]);
    }
    widget.onChange?.call(dotList);
  }

  void startInput() {
    // onStart
    if (!started) {
      started = true;
      widget.onStart?.call();
    }
  }
}
