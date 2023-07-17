import 'package:flutter/material.dart';

class SquareAnimatedScreen extends StatelessWidget {
  const SquareAnimatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: _SquareAnimated()),
    );
  }
}

class _SquareAnimated extends StatefulWidget {
  const _SquareAnimated();

  @override
  State<_SquareAnimated> createState() => _SquareAnimatedState();
}

class _SquareAnimatedState extends State<_SquareAnimated>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> moveRight;
  late Animation<double> moveUp;
  late Animation<double> moveLeft;
  late Animation<double> moveDown;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    moveRight = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0, .25, curve: Curves.bounceOut)));

    moveUp = Tween(begin: 0.0, end: -100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(.25, .5, curve: Curves.bounceOut)));

    moveLeft = Tween(begin: 0.0, end: -100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(.5, .75, curve: Curves.bounceOut)));

    moveDown = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(.75, 1.0, curve: Curves.bounceOut)));

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) controller.reverse();
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
            offset: Offset(moveRight.value + moveLeft.value,
                moveUp.value + moveDown.value),
            child: child!);
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
