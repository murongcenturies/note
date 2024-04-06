// 引入必要的库
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 标题文本组件
class HeaderText extends StatelessWidget {
  // 文本内容
  final String text;

  const HeaderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // 使用 SliverToBoxAdapter 构建可滚动的标题文本
    return SliverToBoxAdapter(
      child: Padding(
        // 设置文本内边距 (左右和上下各 15)
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          // 主轴对齐方式：顶部对齐
          mainAxisAlignment: MainAxisAlignment.start,
          // 交叉轴对齐方式：左侧对齐
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 显示文本
            Text(text, style: context.textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}
