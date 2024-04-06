// 引入 Flutter 库和应用扩展包
import 'package:flutter/material.dart';
import 'package:note/core/core.dart';


// 通用底部应用栏组件
class CommonBottomAppBar extends StatelessWidget {
  // 可选高度 (默认为 55)
  final double? height;

  // 子组件 (用于填充底部应用栏内容)
  final Widget child;

  // 是否显示悬浮按钮 (影响阴影和背景色)
  final bool isShowFAB;

  const CommonBottomAppBar({
    super.key,
    this.height,
    this.isShowFAB = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // 避免底部应用栏被键盘遮挡 (当不显示悬浮按钮时)
    final padding = !isShowFAB ? MediaQuery.of(context).viewInsets : EdgeInsets.zero;

    return Padding(
      padding: padding,
      child: BottomAppBar(
        // 去除默认的表面色和阴影
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,

        // 设置高度 (可自定义)
        height: height ?? 55,

        // 设置凹口形状 (为悬浮按钮留出位置)
        shape: const CircularNotchedRectangle(),

        // 添加阴影 (仅在显示悬浮按钮时)
        elevation: isShowFAB ? 3 : 0,

        // 设置背景色 (根据是否显示悬浮按钮选择)
        color: !isShowFAB
            ? context.colorScheme.background.withOpacity(0) // 透明
            : context.colorScheme.background,

        // 添加子组件 (用于显示内容)
        child: child,
      ),
    );
  }
}
