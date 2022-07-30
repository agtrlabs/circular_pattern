import 'dart:ui';
import 'dart:math';

Offset calcCirclePosition(
  int n,
  Size size,
  int circleCount,
  
  double pointRadius
) {
  double ang = ((2 * pi) / circleCount) * n - (pi / 2);
  Offset center = Offset(size.width / 2, size.height / 2);
  
  double centerRadius = (size.shortestSide - pointRadius/2)/2;

  return Offset(center.dx + (centerRadius - pointRadius) * cos(ang),
      center.dy + (centerRadius - pointRadius) * sin(ang));
}
