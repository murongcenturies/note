import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note/core/core.dart';
import 'package:note/view/home/widgets/item_dismissible_note.dart';

// 网格布局笔记列表 (用于展示多个笔记)
class GridNotes extends StatelessWidget {
  // 笔记列表
  final List<Note> notes;
  // 是否显示可滑动删除 (默认为否)
  final bool isShowDismiss;

  const GridNotes({
    super.key,
    required this.notes,
    this.isShowDismiss = false,
  });

@override
Widget build(BuildContext context) {
  return GetX<HomeController>(
    builder: (controller) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        sliver: _buildMasonryGrid(
          // 根据当前网格状态获取列数
          currentStatusCrossCount(controller.isGridView.value),
        ),
      );
    },
  );
}
  // 根据网格状态获取列数
  int currentStatusCrossCount(GridStatus currentStatus) {
    if (currentStatus == GridStatus.multiView) {
      // 多列视图返回 2 列
      return 2;
    } else {
      // 单列视图返回 1 列
      return 1;
    }
  }

  // 构建网格布局
  SliverMasonryGrid _buildMasonryGrid(int crossAxisCount) {
    return SliverMasonryGrid.count(
      // 设置列数
      crossAxisCount: crossAxisCount,
      // 设置主轴间距 (垂直方向)
      mainAxisSpacing: 8.0,
      // 设置横轴间距 (水平方向)
      crossAxisSpacing: 8.0,
      // 子项数量 (等于笔记列表长度)
      childCount: notes.length,
      // 构建每个子项
      itemBuilder: (_, index) {
        final Note itemNote = notes[index];
        return ItemDismissibleNote(
          // 传递当前笔记信息
          itemNote: itemNote,
          // 是否显示可滑动删除
          isShowDismiss: isShowDismiss,
        );
      },
    );
  }

}