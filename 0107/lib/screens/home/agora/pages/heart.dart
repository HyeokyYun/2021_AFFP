import 'dart:math' as math;
import 'package:flutter/material.dart';

class HeartAnim extends StatelessWidget {
  final double top;
  //final double left;
  final double opacity;

  HeartAnim(
      this.top,
      //this.left,
      this.opacity,
      );

  //

  @override
  Widget build(BuildContext context) {
    final random = math.Random();
    final confetti = Container(
      child: Opacity(
          opacity: 0.95,
          child: Icon(
            Icons.favorite,
            color: const Color(0xffe82b50),
            size: (30 + random.nextInt(30)).toDouble(),
          )),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
    );
    return Positioned(
      bottom: top,
      //right: left,
      child: confetti,
    );
  }
}
