import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../home/widgets/icon_grid_status.dart';
import '../search/notes_searching.dart';

// 归档页面 AppBar (顶部导航栏)
class AppBarEmotion extends StatelessWidget implements PreferredSizeWidget {
  const AppBarEmotion({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 标题: "归档"
      title: const Text('Emotion'),
      // 操作按钮:
      // - 搜索笔记 (使用 AppIcons.searchNote 图标)
      // - 切换网格视图/列表视图 (使用 IconStatusGridNote 图标)
      actions: [
        IconButton(
          onPressed: () => _showSearch(context),
          icon: AppIcons.searchNote,
        ),
        IconStatusGridNote(),
      ],
    );
  }

  // 显示搜索页面
  Future _showSearch(BuildContext context) async {
    // 使用 NotesSearching 委托打开搜索页面
    return showSearch(
      context: context,
      delegate: NotesSearching(),
    );
  }

  // 设置 AppBar 的预设高度
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
