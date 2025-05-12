import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _initTheme();
  }

  final key = PrefKeys.isLight;

  toggleTheme() async {
    final isDark = state == ThemeMode.dark;

    await _ls.setTheme(!isDark);

    await _initTheme();
  }

  final _ls = locate<LocalDB>();

  _initTheme() async {
    final isDark = _ls.getBool(key);

    final result = switch (isDark) {
      null => ThemeMode.light,
      true => ThemeMode.dark,
      false => ThemeMode.light,
    };

    state = result;
  }
}
