import 'package:flutter/material.dart';
import 'package:designs/src/src.dart';
import 'package:provider/provider.dart';

class CircularGraphicsScreen extends StatefulWidget {
  const CircularGraphicsScreen({super.key});

  @override
  State<CircularGraphicsScreen> createState() => _CircularGraphicsScreenState();
}

class _CircularGraphicsScreenState extends State<CircularGraphicsScreen> {
  double percentaje = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circular graphics'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _CustomRadialProgress(
                percentaje: percentaje,
                primaryColor: Colors.black,
                secondaryColor: Colors.brown,
              ),
              _CustomRadialProgress(
                percentaje: percentaje * 1.2,
                primaryColor: Colors.indigo,
                secondaryColor: Colors.pink,
              ),
            ],
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _CustomRadialProgress(
                percentaje: percentaje * 1.4,
                primaryColor: Colors.green,
                secondaryColor: const Color.fromARGB(255, 26, 243, 243),
              ),
              _CustomRadialProgress(
                percentaje: percentaje * 1.6,
                primaryColor: Colors.red,
                secondaryColor: const Color.fromARGB(255, 12, 39, 61),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            percentaje += 10;
            if (percentaje > 100) percentaje = 0;
          });
        },
        child: const Icon(Icons.refresh_outlined),
      ),
    );
  }
}

class _CustomRadialProgress extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  const _CustomRadialProgress({
    required this.percentaje,
    required this.primaryColor,
    required this.secondaryColor,
  });

  final double percentaje;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<ThemeChanger>();
    return SizedBox(
      width: 180,
      height: 180,
      child: RadialProgress(
        percentaje: percentaje,
        primaryColor: primaryColor,
        secondaryColor: appTheme.theme.textTheme.bodyLarge!.color!,
        strokeWithPrimary: 10,
        strokeWithSecondary: 20,
      ),
    );
  }
}
