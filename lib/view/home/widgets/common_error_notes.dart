// 引入 Flutter 库和应用核心类库
import 'package:flutter/material.dart';
import 'package:note/core/core.dart';

import 'common_fix_scrolling.dart';

// 通用错误笔记提示组件
class CommonErrorNotes extends StatelessWidget {
  // 抽屉视图笔记 (用于判断显示哪个错误提示)
  final DrawerSectionView drawerViewNote;

  const CommonErrorNotes({
    Key? key,
    required this.drawerViewNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 根据抽屉视图笔记选择对应的错误提示
    return _switchErrorSection(context, drawerViewNote);
  }

  Widget _switchErrorSection(BuildContext context, DrawerSectionView drawerViewNote) {
    switch (drawerViewNote) {
      case DrawerSectionView.home:
        return CommonFixScrolling(
          // 刷新笔记列表
          onRefresh: () => AppFunction.onRefresh(context),
          child: _errorSection(
            // 显示 "错误" 图标
            AppIcons.error,
            // 提示文本："加载笔记出错"
            'errorMsg',
          ),
        );
      case DrawerSectionView.archive:
        return _errorSection(
          // 显示 "错误" 图标
          AppIcons.error,
          // 提示文本："加载归档笔记出错"
          'errorMsg',
        );
      case DrawerSectionView.trash:
        return _errorSection(
          // 显示 "错误" 图标
          AppIcons.error,
          // 提示文本："加载回收站笔记出错"
          'errorMsg',
        );
    }
  }

  // 创建错误提示子组件
  Widget _errorSection(Icon appIcons, String errorMsg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 显示图标
          appIcons,
          const SizedBox(height: 5.0),
          // 显示提示文本
          Text(errorMsg),
        ],
      ),
    );
  }
}
