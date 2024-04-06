import 'package:flutter/material.dart';
import './widgets/widgets.dart';


// 设置页面
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 页面顶部应用栏
      appBar: AppBar(
        title: const Text('Setting'), // 标题为 “设置”
      ),
      body: const Sections(
        // 分区列表
        sections: [
          // 标题为 “显示选项” 的分块，包含一个 “主题” 项目
          TilesSection(
            title: 'Display option',
            tiles: [ThemesItemTile()],
          ),
        ],
      ),
    );
  }
}
