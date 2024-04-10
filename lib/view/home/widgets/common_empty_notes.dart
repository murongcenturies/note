// 引入 Flutter 库和应用核心类库
import 'package:flutter/material.dart';
import 'package:note/core/core.dart';

import 'common_fix_scrolling.dart';

// 空笔记提示组件
class CommonEmptyNotes extends StatelessWidget {
  // 抽屉视图笔记 (用于判断显示哪个空数据提示)
  final DrawerSectionView drawerViewNote;

 // ignore: use_super_parameters
 const CommonEmptyNotes(this.drawerViewNote, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 根据抽屉视图笔记选择对应的空数据提示
    return _switchEmptySection(context, drawerViewNote);
  }

  Widget _switchEmptySection(BuildContext context, DrawerSectionView drawerViewNote) {
    switch (drawerViewNote) {
      case DrawerSectionView.home:
        return CommonFixScrolling(
          // 刷新笔记列表
          onRefresh: () => AppFunction.onRefresh(context),
          child: _emptySection(
            // 显示 "记事本" 空图标
            AppIcons.emptyNote,
            // 提示文本："您添加的笔记将显示在此处"
            'Note you add appear here',
          ),
        );
      case DrawerSectionView.archive:
        return _emptySection(
          // 显示 "存档" 空图标
          AppIcons.emptyArchivesNote,
          // 提示文本："您存档的笔记将显示在此处"
          'Your archived notes appear here',
        );
      case DrawerSectionView.trash:
        return _emptySection(
          // 显示 "回收站" 空图标
          AppIcons.emptyTrashNote,
          // 提示文本："回收站中没有笔记"
          'No Notes in Recycle Bin',
        );
      case DrawerSectionView.emotion:
          return _emptySection(
          // 显示 "回收站" 空图标
          AppIcons.emptyEmotionNote,
          // 提示文本："这里没有笔记"
          'No Notes in here',
        );
    }
  }

  // 创建空数据提示子组件
  Widget _emptySection(Icon appIcons, String errorMsg) {
        //  print('创建空数据提示子组件');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 显示图标
          appIcons,
          const SizedBox(height: 10.0),
          // 显示提示文本
          Text(
            errorMsg,
            // style: TextStyle(
            //   color: Colors.white,
            // ),
          ),
        ],
      ),
    );
  }
}
