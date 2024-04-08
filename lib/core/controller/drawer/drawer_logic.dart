import 'package:get/get.dart';
import 'package:note/core/core.dart';
import 'package:flutter/material.dart';

//管理抽屉状态和逻辑
class DrawerNavigationController extends GetxController {
  // 定义导航栏的项目列表，使用枚举类中的值
  final List<DrawerViews> navItems = [
    DrawerViews.home,
    DrawerViews.archive,
    DrawerViews.trash,
    DrawerViews.emotion,
    // DrawerViews.setting,
  ];
  // 创建一个全局的 GlobalKey<ScaffoldState> 对象
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // 打开抽屉导航
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  // 定义当前选中的导航栏项目，初始值为首页
  var selectedNavItem = DrawerViews.home.obs;

// 切换导航栏项目
  void changeNavigationItem(DrawerViews item) {
    // 根据枚举值执行相应的页面切换逻辑
    switch (item) {
      case DrawerViews.home:
        Get.toNamed(AppRouterName.home.path);
        selectedNavItem.value = DrawerViews.home;
        break;
      case DrawerViews.archive:
        Get.toNamed(AppRouterName.archive.path);
        selectedNavItem.value = DrawerViews.archive;
        break;
      case DrawerViews.trash:
        Get.toNamed(AppRouterName.trash.path);
        selectedNavItem.value = DrawerViews.trash;
        break;
      case DrawerViews.emotion:
        Get.toNamed(AppRouterName.emotion.path);
        selectedNavItem.value = DrawerViews.emotion;
        break;
      case DrawerViews.setting:
        Get.toNamed(AppRouterName.setting.path);
        selectedNavItem.value = DrawerViews.setting;
        break;
      default:
        // 默认情况下切换到首页
        Get.toNamed(AppRouterName.home.path);
        selectedNavItem.value = DrawerViews.home;
        break;
    }
  }
  DrawerSectionView convertToDrawerSectionView(DrawerViews drawerViews) {
  switch (drawerViews) {
    case DrawerViews.home:
      return DrawerSectionView.home;
    case DrawerViews.archive:
      return DrawerSectionView.archive;
    case DrawerViews.trash:
      return DrawerSectionView.trash;
    // case DrawerViews.emotion:
    //   return DrawerSectionView.emotion;
    default:
      return DrawerSectionView.home; // Default value
  }
}
}
