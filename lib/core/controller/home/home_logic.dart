import 'package:get/get.dart';

import '../../core.dart';

class HomeController extends GetxController {
  // 控制是否显示搜索页面的状态变量
  var isSearchOpen = true.obs;

  var isGridView = GridStatus.singleView.obs;

  // 打开或关闭搜索页面
  void toggleSearch() {
    isSearchOpen.toggle();
  }

  // 切换笔记列表的显示方式
  void toggleView() {
    //     if (isGridView.value == GridStatus.singleView) {
    //   isGridView.value = GridStatus.multiView;
    // } else {
    //   isGridView.value = GridStatus.singleView;
    // }
    // 根据当前状态，切换到反向状态 (单视图 -> 多视图，多视图 -> 单视图)
    isGridView.value = isGridView.value == GridStatus.singleView
        ? GridStatus.multiView
        : GridStatus.singleView;
  }
}
