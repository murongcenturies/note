import 'package:get/get.dart';
import 'package:note/core/core.dart';

// 导入页面类
import 'package:note/view/views.dart';

class AppRouter {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRouterName.login.path, // 路由名称
      page: () => const LoginPage(), // 构建首页页面
    ),
    GetPage(
      name: AppRouterName.home.path, // 路由名称
      page: () => HomePage(), // 构建首页页面
    ),
    GetPage(
      name: AppRouterName.note.path,
      page: () {
        final note = Get.arguments as Note;
        return NotePage(note: note);
      },
    ),
    GetPage(
      name: AppRouterName.setting.path,
      page: () => const SettingPage(),
    ),
    GetPage(
      name: AppRouterName.trash.path,
      page: () => TrashPage(),
    ),
    GetPage(
      name: AppRouterName.archive.path,
      page: () => ArchivePage(),
    ),
        GetPage(
      name: AppRouterName.emotion.path,
      page: () => EmotionPage(),
    ),
  ];
}
