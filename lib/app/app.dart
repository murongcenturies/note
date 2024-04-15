import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/core/core.dart';
import 'initial/initial.dart';

class NoteApp extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());
  // final TranSlationController _tranSlationController = Get.put(TranSlationController());

  NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 在调试模式下不显示 Flutter 的调试横幅
      debugShowCheckedModeBanner: false,
      // 使用 DependencyManager 注册依赖
      initialBinding: DependencyManager(),
      // 应用程序的标题
      // title: 'sparkler',

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // 直接调用 getThemeMode() 方法获取当前应用程序的主题模式对应的 ThemeMode
      themeMode: _themeController.getThemeMode(),
      // 设置初始路由
      initialRoute: AppRouterName.home.path,
      // 设置应用的路由信息
      getPages: AppRouter.routes,
      // 设置默认路由过渡动画
      defaultTransition: Transition.fade,
      //语言设置
      translations: MyTranslations(), //翻译
      // locale:  Locale(_tranSlationController.currentLanguage.value.toString()..split('.').last), //语言
      locale: const Locale('zh'), //语言
    );
  }
}

