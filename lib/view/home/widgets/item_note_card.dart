import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../core/core.dart';

// 笔记卡片条目组件
class ItemNoteCard extends StatelessWidget {
  final Note note; // 笔记数据

  const ItemNoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final document = Document.fromJson(note.content.toJson());
    String plainText = document.toPlainText();
        // 使用 replaceAll('\n', ' ') 方法移除换行符
    plainText = plainText.replaceAll('\n', ' ');
    return Padding(
      // 设置垂直方向内边距
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        // 标题
        title: Padding(
          // 设置垂直方向内边距
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            // 截取标题的前 10 个字符"
            plainText.length <= 8 ? plainText : plainText.substring(0, 8),
            //  : '${note.content.substring(0, 20)} ...',
            style: const TextStyle().copyWith(
              // 设置字体加粗
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // 副标题
        subtitle: Text(
          // 截取内容的前 15 个字符，超过的话加上省略号 "..."
          plainText.length  <= 15
              ? plainText
              : '${plainText.substring(0, 15)} ...',
        ),
      ),
    );
  }
}
