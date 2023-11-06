import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_repository.g.dart';

class ThemeRepository {
  ThemeRepository(this.sharedPreferences);

  final SharedPreferences sharedPreferences;
  final String themeKey = 'theme_mode';

  ThemeMode themeMode() {
    return switch(sharedPreferences.getString(themeKey)) {
      'ThemeMode.dark' => ThemeMode.dark,
      'ThemeMode.light' => ThemeMode.light,
      _ => ThemeMode.system
    };
  }

  Future<ThemeMode> setThemeMode(ThemeMode value) async {
    await sharedPreferences.setString(themeKey, value.toString());
    return themeMode();
  }
}

@Riverpod(keepAlive: true)
ThemeRepository themeRepository(ThemeRepositoryRef ref) {
  // We use UnimplementedError as the sharedPreferences are not available
  // at the startup of the app so we rely on Dependency Override from riverpod
  // to set the value for this provider.
  // Which is going to be ThemeRepository(sharedPreferences)
  throw UnimplementedError();
}
