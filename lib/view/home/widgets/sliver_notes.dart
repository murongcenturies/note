import 'package:flutter/material.dart';
import 'package:note/core/core.dart';
import 'widgets.dart';

// 带滚动效果的笔记列表容器
class SliverNotes extends StatelessWidget {
  // 子 widget（通常为笔记列表）
  final Widget child;

  const SliverNotes({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // 使用 NestedScrollView 实现嵌套滚动效果
    return NestedScrollView(
      // 构建头部，包含 AppBar 和搜索框
      headerSliverBuilder: (_, __) {
        return [_appBar(context)];
      },
      // 内容部分，支持下拉刷新
      body: RefreshIndicator(
        // 下拉刷新触发的位移
        displacement: 80,
        // 下拉刷新时执行的函数
        onRefresh: () => AppFunction.onRefresh(context),
        // 显示笔记列表
        child: child,
      ),
    );
  }

  // 构建 AppBar
  _appBar(BuildContext context) {
    // 使用 SliverPadding 调整 AppBar 位置
    // Padding.fromLTRB: 设置左、上、右、下内边距
    return  SliverPadding(
      // 顶部内边距 (避免顶端搜索栏和其他组件重叠)
      padding: const EdgeInsets.only(top: 15),
      // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      sliver: SliverAppBar(
        // 浮动 AppBar
        floating: true,
        // 快速滚动时吸顶
        snap: true,
        // 无标题间距
        titleSpacing: 0,
        // 工具栏高度
        toolbarHeight: 50,
        // 无导航图标宽度
        leadingWidth: 0,
        // 强制 Material 透明度
        forceMaterialTransparency: true,
        // 标题：通用搜索框
        title: CommonSearchBar(),
        // 设置状态栏样式
        // systemOverlayStyle: context.textTheme,
        // 导航按钮：空占位符
        leading: const SizedBox(),
      ),
    );
  }
}
