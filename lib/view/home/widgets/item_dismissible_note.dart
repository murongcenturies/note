// 引入必要的库
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/view/home/widgets/item_note.dart';

import '../../../core/core.dart';

// 可滑动手势删除的笔记条目组件
class ItemDismissibleNote extends StatelessWidget {
  const ItemDismissibleNote({
    super.key,
    required this.itemNote, // 笔记条目
    required this.isShowDismiss, // 是否显示可滑动手势
  });

  final Note itemNote;
  final bool isShowDismiss;

  @override
  Widget build(BuildContext context) {
    // 根据是否显示可滑动手势删除来决定使用 Dismissible 或 ItemNote
    return isShowDismiss
        ? Dismissible(
      // 可选的背景颜色 (注释掉)
      // background: Container(color: Colors.amber),
      // 唯一标识符 (使用笔记的 ID)
      key: ValueKey<String>(itemNote.id),
      // 要包裹的子组件 (即笔记条目)
      child: ItemNote(note: itemNote),
      // 滑动删除时的回调函数
      onDismissed: (direction) => _onDismissed(context, itemNote),
    )
        : ItemNote(note: itemNote);
  }

  // 滑动删除时的处理函数
  void _onDismissed(BuildContext context, Note itemNote) {
    // 使用 NoteController添加一个移动笔记的事件 (将笔记移动到归档状态)
    Get.find<NoteController>(tag: 'home').moveNote(itemNote, StatusNote.archived);
    // context.read<NoteBloc>().add(MoveNote(itemNote, StatusNote.archived));
  }
}
