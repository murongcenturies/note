// 主题选项单选项
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/core/core.dart';

class ItemTheme extends StatelessWidget {
  final int indexTheme; // 主题索引

  const ItemTheme({
    super.key,
    required this.indexTheme,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Obx(() {
      final currentTheme = themeController.getTheme(); // 当前主题模式
      return RadioListTile<AppThemeMode>(
        // 主题单选按钮
        title: Text(
          AppThemeMode.values[indexTheme].toString().tr,
        ), // 主题标题

        value: AppThemeMode.values[indexTheme], // 主题模式
        groupValue: currentTheme, // 当前选中的主题
        onChanged: (_) => _onChooseTheme(context),
  
      );
    });
  }

  // 切换主题
  void _onChooseTheme(BuildContext context) {
    Get.back(); // 关闭当前页面 (如果为弹窗)
    Get.find<ThemeController>().toggleTheme(); // 切换主题
  }
}
