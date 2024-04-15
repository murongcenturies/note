import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/core/core.dart';

// 菜单项类
class MenuDrawerItem extends StatelessWidget {
  final DrawerViews drawerViews;

  const  MenuDrawerItem(this.drawerViews, {super.key});

  @override
  Widget build(BuildContext context) {
    final DrawerNavigationController drawerController =
        Get.find<DrawerNavigationController>();

    // 处理点击菜单项的事件
    void onTapDrawer(BuildContext context) {
      if (drawerController.selectedNavItem.value != drawerViews) {
        // 如果不是选中的项，则触发该菜单项的点击事件
        drawerController.changeNavigationItem(drawerViews);
      } else {
        // 如果是选中的项，则关闭抽屉
        Navigator.pop(context);
      }
    }

    return Obx(() => Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: ListTile(
            // 设置圆角边框
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            title: Text(drawerViews.name), // 显示菜单项名称
            leading: drawerViews.icon, // 显示菜单项图标
            onTap: () => onTapDrawer(context), // 点击事件处理
            selected: drawerController.selectedNavItem.value == drawerViews, // 设置选中状态
            selectedColor: context.colorScheme.onPrimaryContainer, // 选中时的文本颜色
            selectedTileColor:
                context.colorScheme.primary.withOpacity(0.2), // 选中时的背景色 (半透明)
          ),
        ));
  }
}
