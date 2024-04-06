import 'package:flutter/material.dart';
import 'tiles_section.dart';

// 设置页面分块列表
class Sections extends StatelessWidget {
  final List<TilesSection> sections; // 分区列表

  const Sections({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [...sections], // 展开分块列表构建每一块
    );
  }
}
