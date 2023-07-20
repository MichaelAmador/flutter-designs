import 'dart:math' show min, pi;
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressScreen extends StatefulWidget {
  const CircularProgressScreen({super.key});

  @override
  State<CircularProgressScreen> createState() => _CircularProgressScreenState();
}

class _CircularProgressScreenState extends State<CircularProgressScreen>
    with TickerProviderStateMixin {
  double percentaje = 0;
  double newPercentaje = 0;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    controller.addListener(() {
      // print('${controller.value}');

      percentaje = lerpDouble(percentaje, newPercentaje, controller.value)!;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 300,
          height: 300,
          child: CustomPaint(
            painter: _MyRadialProgress(percentaje),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          percentaje = newPercentaje;
          newPercentaje += 10;
          if (newPercentaje > 100) {
            newPercentaje = 0;
            percentaje = 0;
          }
          controller.forward(from: 0.0);
          setState(() {});
        },
        backgroundColor: Colors.pink,
        child: const Icon(
          Icons.refresh_rounded,
        ),
      ),
    );
  }
}

class _MyRadialProgress extends CustomPainter {
  final double percentaje;

  _MyRadialProgress(this.percentaje);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width * .5, size.height * .5);
    final radius = min(size.width * .5, size.height * .5);

    canvas.drawCircle(center, radius, paint);

    final paintArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;

    final double arcAngle = 2 * pi * (percentaje / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paintArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
