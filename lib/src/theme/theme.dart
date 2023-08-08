import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  bool _darkTheme = false;
  bool _customTheme = false;
  late ThemeData _theme;

  bool get darkTheme => _darkTheme;
  bool get customTheme => _customTheme;
  ThemeData get theme => _theme;

  ThemeChanger(int theme) {
    switch (theme) {
      case 1:
        _darkTheme = false;
        _customTheme = false;
        _theme = ThemeData.light().copyWith(
          colorScheme: const ColorScheme.dark(secondary: Colors.pink),
        );
        break;

      case 2:
        _darkTheme = true;
        _customTheme = false;
        _theme = ThemeData.dark();
        break;

      case 3:
        _darkTheme = false;
        _customTheme = true;
        break;

      default:
        _darkTheme = false;
        _customTheme = false;
        _theme = ThemeData.light();
    }
  }

  set darkTheme(bool value) {
    _customTheme = false;
    _darkTheme = value;

    (value)
        ? _theme = ThemeData.dark()
        : _theme = ThemeData.light().copyWith(
            colorScheme: const ColorScheme.dark(secondary: Colors.pink),
          );

    notifyListeners();
  }

  set customTheme(bool value) {
    _customTheme = value;
    _darkTheme = false;

    (value)
        ? _theme = ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(secondary: Color(0xff48A0EB)),
            primaryColorLight: Colors.white,
            scaffoldBackgroundColor: const Color(0xff16202b),
            textTheme:
                const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
          )
        : _theme = ThemeData.light();

    notifyListeners();
  }
}
