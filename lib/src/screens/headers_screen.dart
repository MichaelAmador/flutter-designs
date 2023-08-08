import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../src.dart';

class HeaderScreen extends StatelessWidget {
  const HeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<ThemeChanger>();
    return SafeArea(
        child: Scaffold(
            body: HeaderWave(
      color: appTheme.theme.colorScheme.secondary,
    )));
  }
}
