// 主题设置列表项
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'item_theme.dart';

import '../../../core/core.dart';

class ThemesItemTile extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ThemesItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Obx(() {
      final currentTheme = themeController.getTheme(); // 当前主题模式

      return ListTile(
        title: Text(I18nContent.theme.tr), // 标题为 “主题”
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // 设置Row的主轴大小为最小
          children: <Widget>[
            themeController.getThemeIcon(), // 显示当前主题对应的图标
            const SizedBox(width: 8), // 添加一些间距
            Text(
              currentTheme.toString().tr, // 显示当前主题的枚举值名称
              style: context.textTheme.bodyLarge, // 设置文本样式
            ),
          ],
        ),
        leading: AppIcons.drawColor, // 左侧图标为主题图标
        onTap: () => _showThemesDialog(context), // 点击事件：显示主题选择弹窗
      );
    });
  }

  // 显示主题选择弹窗
  Future<void> _showThemesDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // 设置内容内边距
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          title: Text(I18nContent.chooseTheme.tr), // 弹窗标题为 “选择主题”
          content: Column(
            // 设置最小高度，使其内容自适应
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              AppThemeMode.values.length, // 循环生成主题选项列表
              (itemThemeIndex) =>
                  ItemTheme(indexTheme: itemThemeIndex), // 构建每个主题选项
            ),
          ),
        );
      },
    );
  }
}
