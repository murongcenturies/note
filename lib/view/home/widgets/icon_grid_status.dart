// 引入必要的库
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/core/core.dart';

// 网格视图状态图标组件
class IconStatusGridNote extends StatelessWidget {
  IconStatusGridNote({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
            return IconButton(
              // 根据isGridView的值显示不同的图标
              icon: Icon(_iconCurrentStatus(homeController.isGridView.value)),
              onPressed: homeController.toggleView,
            );
          });
  }

  // 根据网格视图状态返回对应的图标
  IconData _iconCurrentStatus(GridStatus currentStatus) =>
      currentStatus == GridStatus.singleView
          ? GridStatus.singleView.icon
          : GridStatus.multiView.icon;
}
