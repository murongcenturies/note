import 'package:flutter/material.dart';

import '../../../core/core.dart';

// 笔记卡片条目组件
class ItemNoteCard extends StatelessWidget {
  final Note note; // 笔记数据

  const ItemNoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // 设置垂直方向内边距
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        // 标题
        title: Padding(
          // 设置垂直方向内边距
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            // 截取标题的前 80 个字符，超过的话加上省略号 "..."
            note.content.length <= 20
                ? note.content
                : '${note.content.substring(0, 20)} ...',
            style: const TextStyle().copyWith(
              // 设置字体加粗
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // 副标题
        subtitle: Text(
          // 截取内容的前 180 个字符，超过的话加上省略号 "..."
          note.content.length <= 180
              ? note.content
              : '${note.content.substring(0, 180)} ...',
        ),
        // 注释掉原有的 leading 属性 (不显示笔记 ID)
        // leading: Text(itemNote.id.toString()),
      ),
    );
  }
}
