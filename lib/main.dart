import 'package:designs/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  // FORCE ONLY PORTRAIT MODE
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(ChangeNotifierProvider(
      create: (_) => ThemeChanger(2), child: const MainApp()));
}

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
          final screenSize = MediaQuery.of(context).size;

          if (screenSize.width > 500) {
            return const LauncherTabletScreen();
          }

          return const LauncherScreen();
        },
      ),
    );
  }
}
