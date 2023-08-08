import 'package:designs/src/src.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (_) => ThemeChanger(2), child: const MainApp()));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<ThemeChanger>().theme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: OrientationBuilder(
        builder: (context, orientation) {
          return const LauncherScreen();
        },
      ),
    );
  }
}
