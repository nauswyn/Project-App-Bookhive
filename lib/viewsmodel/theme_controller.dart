import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme_service.dart';

class ThemeController extends GetxController {
  final ThemeService _themeService = ThemeService();
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeMode();
  }

  Future<void> loadThemeMode() async {
    final savedThemeMode = await _themeService.getThemeMode();
    themeMode.value = savedThemeMode;
  }

  Future<void> setThemeMode(ThemeMode selectedMode) async {
    themeMode.value = selectedMode;
    await _themeService.setThemeMode(selectedMode);
    Get.changeThemeMode(selectedMode);
  }
}
