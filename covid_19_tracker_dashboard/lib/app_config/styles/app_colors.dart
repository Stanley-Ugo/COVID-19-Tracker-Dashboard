import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

// export screen util
void setDarkModeSetting(BuildContext context, ThemeMode themeMode) =>
    MyApp.of(context).setThemeMode(themeMode);

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

enum DeviceSize { mobile, tablet, desktop }

abstract class ThemeColors {
  static DeviceSize deviceSize = DeviceSize.mobile;

  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) =>
      mode == ThemeMode.system
          ? _prefs?.remove(kThemeModeKey)
          : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static ThemeColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  late Color primaryColor;
  late Color secondaryColor;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color lightPrimaryColor;
  late Color lightBlue;
  late Color lightGrey;
  late Color coolGrey;
  late Color inputHint;
  late Color lineGrey;
  late Color lightGreen;
  late Color lightBasicPrimary;
  late Color appWhite;
  late Color appBlack;
  late Color primaryText;
  late Color secondaryText;
  late Color success;
  late Color warning;
  late Color error;
  late Color lightError;
}

class LightModeTheme extends ThemeColors {
  // late Color primaryColor = const Color(0xFFF7AF0F);
  late Color primaryColor = Colors.redAccent.withOpacity(0.6);

  late Color secondaryColor = const Color(0xFF061D2D);
  late Color primaryBackground = const Color(0xFFFFFFFF);
  late Color secondaryBackground = const Color(0xFFF5F5F5);
  late Color lightPrimaryColor = const Color(0xFF496069);
  late Color lightBlue = const Color(0xFFDEEFF5);
  late Color lightGrey = const Color(0xFFBDBDBD);
  late Color lineGrey = const Color(0xFFBDBDBD);
  late Color coolGrey = const Color(0xFF5c5858);

  late Color lightGreen = const Color(0xFFDAE9D2);
  late Color appBlack = const Color(0xFF000000);
  late Color lightBasicPrimary = const Color(0xFFE8D5AB);

  late Color appWhite = const Color(0xFFFFFFFF);
  late Color primaryText = const Color(0xFF212121);
  late Color secondaryText = const Color(0xFF606F7F);
  late Color success = const Color(0xFF4EB570);
  late Color warning = const Color(0xFFF7AF0F);
  late Color error = const Color(0xFFF13535);
  late Color lightError = const Color(0xFFFFEBE6);
  late Color inputHint = const Color(0xFF999999);
}

class DarkModeTheme extends ThemeColors {
  // late Color primaryColor = const Color(0xFFF7AF0F);
  late Color primaryColor = Colors.redAccent.withOpacity(0.6);
  late Color secondaryColor = const Color(0xFF061D2D);
  late Color primaryBackground = const Color(0xFF212024);
  late Color secondaryBackground = const Color(0xFF1f1e21);
  late Color lightPrimaryColor = const Color(0xFF496069);
  late Color lightBlue = const Color(0xFFDEEFF5);
  late Color lightGrey = const Color(0xFFBDBDBD);
  late Color lineGrey = const Color(0xFFE8EAEE);
  late Color coolGrey = const Color(0xFFE4E4E4);
  late Color lightGreen = const Color(0xFFDAE9D2);
  late Color appBlack = const Color(0xFF000000);
  late Color lightBasicPrimary = const Color(0xFFE8D5AB);
  late Color inputHint = const Color(0xFF999999);

  late Color appWhite = const Color(0xFFFFFFFF);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFFe9edf2);
  late Color success = const Color(0xFF4EB570);
  late Color warning = const Color(0xFFF7AF0F);
  late Color error = const Color(0xFFF13535);
  late Color lightError = const Color(0xFFFFEBE6);
}
