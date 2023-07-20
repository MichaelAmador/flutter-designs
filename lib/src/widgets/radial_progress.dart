import 'package:flutter/material.dart';
import 'dart:math' show min, pi;

class RadialProgress extends StatefulWidget {
  final double percentaje;
  final Color primaryColor;
  final Color secondaryColor;
  final double strokeWithPrimary;
  final double strokeWithSecondary;
  const RadialProgress(
      {super.key,
      required this.percentaje,
      this.primaryColor = Colors.indigo,
      this.secondaryColor = Colors.grey,
      this.strokeWithPrimary = 10,
      this.strokeWithSecondary = 10});

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double lastPercentaje;

  @override
  void initState() {
    lastPercentaje = widget.percentaje;
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final differenceAnimation = widget.percentaje - lastPercentaje;
    lastPercentaje = widget.percentaje;

    return AnimatedBuilder(
      animation: controller,
      // child: child,
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
              painter: _MyRadialProgress(
                  (widget.percentaje - differenceAnimation) +
                      (differenceAnimation + controller.value),
                  widget.primaryColor,
                  widget.secondaryColor,
                  widget.strokeWithPrimary,
                  widget.strokeWithSecondary)),
        );
      },
    );
  }
}

class _MyRadialProgress extends CustomPainter {
  final double percentaje;
  final Color primaryColor;
  final Color secondaryColor;
  final double strokeWithPrimary;
  final double strokeWithSecondary;

  _MyRadialProgress(this.percentaje, this.primaryColor, this.secondaryColor,
      this.strokeWithPrimary, this.strokeWithSecondary);
  @override
  void paint(Canvas canvas, Size size) {
    const gradient = LinearGradient(colors: [
      Color(0xffc012ff),
      Color(0xff6d05e8),
      Colors.red,
    ]);

    final rect = Rect.fromCircle(center: const Offset(0, 0), radius: 180);

    final paint = Paint()
      ..strokeWidth = strokeWithSecondary
      ..color = secondaryColor
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width * .5, size.height * .5);
    final radius = min(size.width * .5, size.height * .5);

    canvas.drawCircle(center, radius, paint);

    final paintArc = Paint()
      ..strokeWidth = strokeWithPrimary
      ..color = primaryColor
      // ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double arcAngle = 2 * pi * (percentaje / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paintArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
