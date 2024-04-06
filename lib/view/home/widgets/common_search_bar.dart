import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/core/core.dart';
import 'widgets.dart';
// 通用搜索栏组件
class CommonSearchBar extends StatelessWidget {
   CommonSearchBar({super.key});

  final DrawerNavigationController drawerController = Get.find();
  // 搜索提示文本
  final String hintText = 'Search your notes';
  // 打开侧边栏方法
  void _openDrawer(BuildContext context) {
    drawerController.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    // 搜索栏内边距
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        // 宽度充满父容器
        width: double.infinity,
        child: Material(
          // 圆角样式
          borderRadius: BorderRadius.circular(25),
          child: InkWell(
            // 点击效果 (圆角样式)
            borderRadius: BorderRadius.circular(25),
            onTap: homeController.toggleSearch, // 调用 HomeController 的 toggleSearch 方法
            // onTap: () => _showSearch(context), // 点击搜索
            child: Row(
              // 子元素水平对齐 (左右两端对齐)
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  // 子元素水平排列
                  children: [
                    // 菜单按钮
                    IconButton(
                      icon: AppIcons.menu, // 菜单图标
                      onPressed: () => _openDrawer(context), // 打开侧边栏
                    ),
                    // 提示文本
                    Text(hintText, style: context.textTheme.bodyLarge),
                  ],
                ),
                 Row(
                  // 右侧图标 (网格视图和个人资料)
                  children: [
                    IconStatusGridNote(), // 网格视图图标
                    // IconProfile(), // 个人资料图标
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }


  // 显示搜索界面方法
  // Future _showSearch(BuildContext context) =>;
      // showSearch(context: context, delegate: NotesSearching());
}