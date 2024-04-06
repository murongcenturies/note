// 引入 Flutter 库和应用核心类库
import 'package:flutter/material.dart';
import 'package:note/core/core.dart';
import 'widgets.dart';

// 通用笔记加载中提示组件
class CommonLoadingNotes extends StatelessWidget {
  // 笔记部分 (用于判断显示哪个加载中提示)
  final DrawerSectionView noteSection;

  const CommonLoadingNotes(
      this.noteSection, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 根据笔记部分选择对应的加载中提示
    return switchLoadingViewNotesSection(context, noteSection);
  }

  Widget switchLoadingViewNotesSection(
      BuildContext context,
      DrawerSectionView drawerViewNote,
      ) {
    switch (drawerViewNote) {
      case DrawerSectionView.home:
      //  print('1');
        return CommonFixScrolling(
          // 刷新回调函数
          onRefresh: () => AppFunction.onRefresh(context),
          child: const CircularProgressIndicator(), // 圆形进度条
        );
      case DrawerSectionView.archive:
        return const Center(child: CircularProgressIndicator()); // 居中显示圆形进度条
      case DrawerSectionView.trash:
        return const Center(child: CircularProgressIndicator()); // 居中显示圆形进度条
    }
  }
}
