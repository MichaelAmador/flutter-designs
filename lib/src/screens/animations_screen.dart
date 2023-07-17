import 'package:flutter/material.dart';
import 'dart:math' show pi;

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _AnimatedRectangle(),
      ),
    );
  }
}

class _AnimatedRectangle extends StatefulWidget {
  const _AnimatedRectangle();

  @override
  State<_AnimatedRectangle> createState() => _AnimatedRectangleState();
}

class _AnimatedRectangleState extends State<_AnimatedRectangle>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation;
  late Animation<double> opacity;
  late Animation<double> opacityOut;
  late Animation<double> moveRight;
  late Animation<double> scaleUp;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    rotation = Tween(begin: 0.0, end: 2.0 * pi).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));

    opacity = Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0, .25, curve: Curves.easeOut)));

    opacityOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(.75, 1, curve: Curves.easeOut)));

    moveRight = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0, .25, curve: Curves.easeOut)));

    scaleUp = Tween(begin: 1.0, end: 2.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0, .25, curve: Curves.easeOut)));

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) controller.reverse();

      // if (controller.status == AnimationStatus.dismissed) controller.forward();
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
    controller.repeat();
    return AnimatedBuilder(
      animation: controller,
      child: _Rectangle(),
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(moveRight.value, 0),
          child: Transform.rotate(
              angle: rotation.value,
              child: Opacity(
                  opacity: opacity.value - opacityOut.value,
                  child: Transform.scale(scale: scaleUp.value, child: child!))),
        );
      },
    );
  }
}

class _Rectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(color: Colors.blue),
    );
  }
}
