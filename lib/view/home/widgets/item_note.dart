import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/view/home/widgets/item_note_card.dart';

import '../../../../../../core/core.dart';

// 笔记列表中的单个笔记项
class ItemNote extends StatelessWidget {
  final Note note; // 笔记数据

  const ItemNote({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // 设置卡片背景色 (根据笔记颜色索引获取颜色)
      // color: ColorNote.getColor(context, note.colorIndex),
      // 去除外边距
      margin: EdgeInsets.zero,
      // 设置阴影效果
      elevation: .3,
      child: InkWell(
        // 设置圆角
        borderRadius: BorderRadius.circular(15),
        // 子组件为 ItemNoteCard (展示笔记内容)
        child: ItemNoteCard(note: note),
        // 点击事件，触发获取笔记详情的事件
        onTap: () => _onTapItem(context),
      ),
    );
  }

  // 点击笔记项触发的事件，获取该笔记的详细信息
  void _onTapItem(BuildContext context) {
    // 使用 GetX 获取 DrawerNavigationController
    final DrawerNavigationController drawerController =
      Get.find<DrawerNavigationController>();
        // 获取当前选中的视图
    final selectedView = drawerController
        .convertToDrawerSectionView(drawerController.selectedNavItem.value);
    // 获取视图名称
    String name = selectedView.toString().split('.').last;
    // print(name);
    // 使用 NoteController 获取笔记详情
    Get.find<NoteController>(tag: name).getById(note.id);
    // context.read<NoteBloc>().add(GetNoteById(note.id));
  }
}
