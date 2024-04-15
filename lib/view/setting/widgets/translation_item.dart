// 主题设置列表项
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/core.dart';
import 'item_translation.dart';

class TranslationItemTile extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  TranslationItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    final TranSlationController controller = Get.find();
    return Obx(() {
      final currentLanguage = controller.currentLanguage; // 当前语言

      return ListTile(
        title: Text(I18nContent.language.tr), // 标题为 “语言”
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // 设置Row的主轴大小为最小
          children: <Widget>[
            SvgPicture.asset(
            controller.getIcon(), // 显示当前语言对应的svg图标
             height: 20.0, width: 20.0, // 设置图标大小
            ),
            const SizedBox(width: 8), // 添加一些间距
            Text(
              currentLanguage.value.toString().tr, // 显示当前语言名称
              style: context.textTheme.bodyLarge, // 设置文本样式
            ),
          ],
        ),
        leading: AppIcons.language, // 左侧图标
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
          title: Text(I18nContent.changeLanguage.tr), // 弹窗标题为 “更改语言”
          content: Column(
            // 设置最小高度，使其内容自适应
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              AppLanguage.values.length, // 循环生成选项列表
              (itemLanguage) =>
                  ItemTranslation(indexLanguage: itemLanguage), // 构建每个选项
            ),
          ),
        );
      },
    );
  }
}
