import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 设置页面分块
class TilesSection extends StatelessWidget {
  final String title; // 分块标题
  final List<Widget> tiles; // 分块内项目列表

  const TilesSection({super.key, required this.title, required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Column(
      // 主轴顶部对齐
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          // 设置内边距
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8.0,
          ),
          child: Align(
            // 左对齐
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              // 设置文本样式
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold, // 加粗
              ),
            ),
          ),
        ),
        // 展开项目列表构建每一项
        ...tiles
      ],
    );
  }
}
