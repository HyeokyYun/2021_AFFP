import 'dart:math';
import 'package:flutter/material.dart';

class PieChart extends CustomPainter {
  int percentage = 0;
  Offset? location;

  PieChart({required this.percentage, this.location});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black.withOpacity(0.0) // 화면에 그릴 때 쓸 Paint를 정의합니다.
      ..strokeWidth = 10.0 // 선의 길이를 정합니다.
      ..style =
          PaintingStyle.stroke // 선의 스타일을 정합니다. stroke면 외곽선만 그리고, fill이면 다 채웁니다.
      ..strokeCap =
          StrokeCap.butt; // stroke의 스타일을 정합니다. round를 고르면 stroke의 끝이 둥글게 됩니다.

    double radius = min(
        size.width / 2 - paint.strokeWidth / 2,
        size.height / 2 -
            paint.strokeWidth / 2); // 원의 반지름을 구함. 선의 굵기에 영향을 받지 않게 보정함.
    Offset? center = location; // 원이 위젯의 가운데에 그려지게 좌표를 정함.

    canvas.drawCircle(center!, radius, paint); // 원을 그림.

    double arcAngle =
        2 * pi * (percentage / 100); // 호(arc)의 각도를 정함. 정해진 각도만큼만 그리도록 함.

    paint.color = Colors.deepPurpleAccent; // 호를 그릴 때는 색을 바꿔줌.
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paint); // 호(arc)를 그림.
  }

  @override
  bool shouldRepaint(PieChart old) {
    return old.percentage != percentage;
  }
}
