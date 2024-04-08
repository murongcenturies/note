import 'package:flutter/material.dart';

// 回收站应用栏
class AppBarTrash extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTrash({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 标题： “回收站”
      title: const Text('Trash'),
    );
  }

  @override
  // 优先大小：与工具栏高度一致
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
