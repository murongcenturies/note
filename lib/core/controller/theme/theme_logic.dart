import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:note/core/core.dart';


class ThemeController extends GetxController {
  Rx<AppThemeMode> currentTheme = AppThemeMode.light.obs;

  @override
  void onInit() {
    super.onInit();
    // 加载主题设置
    loadTheme();
  }

  /// 设置主题模式并保存到持久化存储
  ///
  /// [mode] 要设置的主题模式
  void setTheme(AppThemeMode mode) async {
    currentTheme.value = mode;
    // 手动更新
    Get.forceAppUpdate();
    // 保存主题设置
    await saveTheme(mode);
  }

  /// 获取当前主题模式
  ///
  /// 返回当前应用程序的主题模式
  AppThemeMode getTheme() {
    return currentTheme.value;
  }

  /// 获取当前主题模式对应的 ThemeMode
  ///
  /// 返回当前应用程序的主题模式对应的 ThemeMode
  ThemeMode getThemeMode() {
    return currentTheme.value == AppThemeMode.light
        ? ThemeMode.light
        : ThemeMode.dark;
  }

  /// 根据当前主题模式返回对应的图标
  ///
  /// 返回当前应用程序的主题模式对应的图标
  Icon getThemeIcon() {
    return currentTheme.value == AppThemeMode.light
        ? AppIcons.light
        : AppIcons.dark;
  }

  /// 切换主题模式
  ///
  /// 根据当前主题模式切换为相反的主题模式
  void toggleTheme() {
    setTheme(currentTheme.value == AppThemeMode.light
        ? AppThemeMode.dark
        : AppThemeMode.light);
  }

  /// 加载主题设置的逻辑
  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeValue = prefs.getString('theme_mode');
    if (themeValue != null) {
      currentTheme.value =
          themeValue == 'light' ? AppThemeMode.light : AppThemeMode.dark;
    }
  }

  /// 保存主题设置的逻辑
  Future<void> saveTheme(AppThemeMode mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'theme_mode', mode == AppThemeMode.light ? 'light' : 'dark');
  }
}
