// lib/ui/providers/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_base_template/ui/theme/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// StateNotifier to manage ThemeMode
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark);

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  void setTheme(ThemeMode mode) {
    state = mode;
  }
}

// Provider for ThemeMode
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

// Provider for AppTheme
final appThemeProvider = Provider<AppTheme>((ref) {
  final mode = ref.watch(themeModeProvider);
  return mode == ThemeMode.dark ? AppTheme.dark() : AppTheme.light();
});
