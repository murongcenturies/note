import 'package:get/get.dart';

import '../../core.dart';

class HomeController extends GetxController {
  // 定义状态变量
  var isGridView = GridStatus.singleView.obs;
  // 切换笔记列表的显示方式
  void toggleView() {

    // 根据当前状态，切换到反向状态 (单视图 -> 多视图，多视图 -> 单视图)
    isGridView.value = isGridView.value == GridStatus.singleView
        ? GridStatus.multiView
        : GridStatus.singleView;
  }
}
