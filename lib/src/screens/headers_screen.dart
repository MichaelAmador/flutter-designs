import 'package:flutter/material.dart';

import '../src.dart';

class HeaderScreen extends StatelessWidget {
  const HeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: HeaderWaveGradient()));
  }
}
