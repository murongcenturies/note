import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
// 应用图标 (不可变类)
@immutable
class AppIcons {
  const AppIcons._(); // 私有构造函数

  // 通用图标
  static const arrowBack = Icon(Icons.arrow_back_rounded); // 左返回箭头
  static const leftBack = Icon(Icons.arrow_forward_rounded); // 返回箭头

  static const home = Icon(Icons.home); //主页按钮

  // 抽屉 (Drawer) 图标
  static const pen = Icon(Icons.mode_edit_outline_rounded); // 编辑
  static const archive = Icon(Icons.archive_rounded); // 存档
  static const trash = Icon(Icons.delete); // 删除
  static const setting = Icon(Icons.settings); // 设置
  static const emotion = Icon(Icons.emoji_emotions_outlined); // 情绪

  // 搜索栏 (SearchBar) 图标
  static const menu = Icon(Icons.menu_sharp); // 菜单
  static const grip = Icons.view_agenda_outlined; // 列表视图
  static const gripVertical = Icons.grid_view_outlined; // 网格视图
  static const searchNote = Icon(Icons.search); // 搜索笔记

  // 主页 (HomePage) 图标
  static const add = Icon(Icons.add); // 新增
  static const speaker = Icon(Icons.speaker_notes);

  // 笔记详情页 (NotePage) 图标
  static const archiveNote = Icon(Icons.archive_outlined); // 存档笔记
  static const unarchiveNote = Icon(Icons.unarchive_outlined); // 取消存档笔记

  static const pin = Icons.push_pin_rounded; // 固定
  static const unPin = Icons.push_pin_outlined; // 取消固定

  static const redo = Icon(Icons.redo); // 重做
  static const undo = Icon(Icons.undo); // 撤销


  static const drawColor = Icon(Icons.color_lens_outlined); // 选择颜色

  static const defuaulCheckColor = Icon(Icons.format_color_reset_outlined); // 默认勾选框颜色
  static const check = Icon(Icons.check_rounded, color: Colors.blueAccent); // 勾选框 (蓝色)

  static const trashNote = Icon(Icons.delete_outline_rounded); // 删除笔记
  // static const sendNote = Icon(Icons.share_sharp); // 分享笔记

  static const deleteNote = Icon(Icons.delete_forever_outlined); // 永久删除笔记
  static const restoreNote = Icon(Icons.restore); // 还原笔记

  static const light = Icon(Icons.light_mode); // 主题明
  static const dark = Icon(Icons.dark_mode); // 主题明

  static const email = Icon(Icons.email, color: Colors.grey,); // 灰色邮箱
  static const password = Icon( Icons.lock, color: Colors.grey,); // 灰色密码

  // 空状态图标
  static const emptySearch = Icon(Icons.search, size: 100); // 空搜索
  static const emptyNote = Icon(Icons.landscape_outlined, size: 150); // 空笔记
  static const emptyArchivesNote = Icon(Icons.archive_outlined, size: 150); // 空存档笔记
  static const emptyTrashNote = Icon(Icons.delete_outline_rounded, size: 150); // 空回收站笔记

  // 错误状态图标
  static const error = Icon(Icons.error_outline_outlined, size: 150); // 错误

 //窗口操作图标
  static const max = Icon(EvaIcons.squareOutline ); // 最大化
  static const min = Icon(EvaIcons.minusSquareOutline ); // 最小化
  static const close = Icon(EvaIcons.closeSquareOutline ); // 关闭
  //logo
  static const logo=('assets/icon/Icon.png');
  //background
  static const cloud=('assets/background/werow.png');
  //编辑器
  static const more = Icon(Icons.more_vert_outlined); // 更多
  static const share = Icon(Icons.share); // 分享
  static const print = Icon(Icons.print); // 更多
  // 用户头像
  // static final List<String> profiles = [
  //   'assets/avaters/profile_1.png',
  //   'assets/avaters/profile_2.png',
  //   'assets/avaters/profile_3.png',
  //   'assets/avaters/profile_4.png',
  //   'assets/avaters/profile_5.png',
  // ];
}
