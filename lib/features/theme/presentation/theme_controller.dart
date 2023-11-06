import 'package:app_template/features/theme/data/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_controller.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  @override
  FutureOr<ThemeMode> build() {
    _repository = ref.watch(themeRepositoryProvider);
    return _repository.themeMode();
  }

  late ThemeRepository _repository;

  Future<void> setThemeMode(ThemeMode value) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return _repository.setThemeMode(value);
    });
  }
}
