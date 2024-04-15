// 主题选项单选项
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/core/core.dart';

class ItemTranslation extends StatelessWidget {
  final int indexLanguage; // 主题索引

  const ItemTranslation({
    super.key,
    required this.indexLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final TranSlationController controller = Get.find();
    return Obx(() {
      final currentLanguage = controller.currentLanguage.value; // 当前语言
      return RadioListTile<AppLanguage>(
        // 主题单选按钮
        title: Text(
          AppLanguage.values[indexLanguage].toString().tr,
        ), // 主题标题

        value: AppLanguage.values[indexLanguage], // 主题模式
        groupValue: currentLanguage, // 当前选中的主题
        onChanged: (_) => _onChooseTheme(context),
  
      );
    });
  }

  // 切换主题
  void _onChooseTheme(BuildContext context) {
    Get.back(); // 关闭当前页面 (如果为弹窗)
    Get.find<TranSlationController>().toggleLanguage(); // 切换主题
  }
}
