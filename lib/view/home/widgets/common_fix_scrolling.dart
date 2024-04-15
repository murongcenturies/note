import 'package:flutter/material.dart';
import 'widgets.dart';

// 阻止滚动越界的滚动行为类 (私有类)
class _ClampingScrollBehavior extends ScrollBehavior {
  @override
  // 始终使用 ClampingScrollPhysics 滚动物理特性，防止滚动越界
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

// 常用可刷新滚动组件
class CommonFixScrolling extends StatelessWidget {
  // 刷新回调函数
  final Future<void> Function() onRefresh;

  // 子组件 (用于填充可刷新滚动内容)
  final Widget child;

  // ignore: use_super_parameters
  const CommonFixScrolling({
    Key? key,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((_, constraints) {
        return RefreshIndicator(
          // 设置下拉刷新回调
          onRefresh: onRefresh,

          // 设置下拉刷新偏移量 (避免和其他组件冲突)
          edgeOffset: 90,

          child: ScrollConfiguration(
            // 自定义滚动行为 (适用于所有平台)
            behavior: _ClampingScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              // 始终允许滚动 (即使内容不足以填满屏幕)
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                // 限制子组件的最小/最大高度 (等于父组件的高度)
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  maxHeight: constraints.maxHeight,
                ),
                child: SafeArea(
                  // 避免子组件溢出安全区域
                  child: Column(
                    // 将子组件垂直居中对齐
                    mainAxisAlignment: MainAxisAlignment.center,
                    // 将子组件水平居中对齐
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        // 顶部内边距 (避免顶端搜索栏和其他组件重叠)
                        padding: const EdgeInsets.only(top: 15),
                        child: CommonSearchBar(), // 搜索栏组件
                      ),

                      /// 填充可用空间，并具有固定高度为0的小部件。
                      const Expanded(child: SizedBox(height: 0)),
                      child, // 子组件
                      const Expanded(child: SizedBox(height: 0)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
