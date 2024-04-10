import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

// 笔记详情页面的 “存档” 按钮
class IconArchiveStatus extends StatelessWidget {
  // ignore: use_super_parameters
  const IconArchiveStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatusIconsController>(
      builder: (controller) {
        final currentNote = controller.currentNote; // 当前笔记
        final currentNoteStatus = controller.currentNoteStatus; // 当前笔记状态
        final currentArchiveStatus = controller.currentArchiveStatus; // 当前存档状态

        return IconButton(
          // 设置图标，根据当前存档状态选择合适的图标
          icon: _iconCurrentStatus(currentArchiveStatus.value),
          // 点击按钮触发归档/取消归档操作
          onPressed: () => _onToggleArchiveStatus(
            currentNote: currentNote.value,
            currentNoteStatus: currentNoteStatus.value,
          ),
        );
      },
    );
  }

  // 根据当前存档状态返回对应的图标
  Icon _iconCurrentStatus(ArchiveStatus currentStatus) {
    if (currentStatus == ArchiveStatus.archive) {
      // 已归档状态，使用 “取消归档” 图标
      return AppIcons.unarchiveNote;
    } else {
      // 未归档状态，使用 “归档” 图标
      return AppIcons.archiveNote;
    }
  }

  // 触发归档/取消归档操作
  void _onToggleArchiveStatus({
    required Note currentNote,
    required StatusNote currentNoteStatus,
  }) {
    // 根据当前笔记状态，确定新的笔记状态
    final newNoteStatus = currentNoteStatus == StatusNote.archived
        ? StatusNote.undefined // 取消归档后，状态变为未定义
        : StatusNote.archived; // 归档后，状态变为已归档

    //通知更新笔记状态
    Get.find<NoteController>(tag: 'home').moveNote(currentNote, newNoteStatus);
    // if (Get.currentRoute == AppRouterName.home.path) {
    //   Get.back();
    // } else {
    //   Get.offNamedUntil(AppRouterName.home.path, (route) => false);
    // }
  }
}
