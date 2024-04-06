import 'package:note/core/core.dart';
import 'package:flutter/material.dart';
import 'package:note/core/hive/state_note_hive.dart';

// 扩展 BuildContext 类，提供便捷访问主题、文本样式和颜色方案
extension BuildContextExtensions on BuildContext {
  /// 获取当前主题
  ThemeData get theme => Theme.of(this);

  /// 获取当前文本样式
  // TextTheme get textTheme => theme.textTheme;

  /// 获取当前配色方案
  ColorScheme get colorScheme => theme.colorScheme;

  /// 获取设备尺寸
  Size get deviceSize => MediaQuery.of(this).size;
}

// 扩展 GridStatus 枚举，根据状态返回对应的图标
extension StateGridViewIcon on GridStatus {
  /// 获取对应的图标
  IconData get icon {
    switch (this) {
      case GridStatus.singleView:
        return AppIcons.grip;
      case GridStatus.multiView:
        return AppIcons.gripVertical;
    }
  }
}
// 扩展 DrawerViews 枚举，提供便捷访问名称、图标和点击事件处理

extension DrawerViewsExtensions on DrawerViews {
  /// 获取对应的名称
  String get name {
    switch (this) {
      case DrawerViews.home:
        return 'Notes';
      case DrawerViews.archive:
        return 'Archive';
      case DrawerViews.trash:
        return 'Trash';
      case DrawerViews.emotion:
        return 'Emotion';
      case DrawerViews.setting:
        return 'Setting';
    }
  }
  /// 获取对应的图标
  Icon get icon {
    switch (this) {
      case DrawerViews.home:
        return AppIcons.pen;
      case DrawerViews.archive:
        return AppIcons.archive;
      case DrawerViews.trash:
        return AppIcons.trash;
      case DrawerViews.emotion:
        return AppIcons.emotion;
      case DrawerViews.setting:
        return AppIcons.setting;
    }
  }
}

// 扩展 StatusNote 枚举，根据枚举值获取对应的 StateNoteHive 值
extension StatusNoteX on StatusNote {
  /// 获取对应的 StateNoteHive 值
  StateNoteHive get stateNoteHive {
    switch (this) {
      case StatusNote.undefined:
        return StateNoteHive.unspecified;
      case StatusNote.pinned:
        return StateNoteHive.pinned;
      case StatusNote.archived:
        return StateNoteHive.archived;
      case StatusNote.trash:
        return StateNoteHive.trash;
    }
  }
}

// 扩展 StateNoteHive 枚举，根据枚举值获取对应的 StatusNote 值
extension StatusHiveNoteX on StateNoteHive {
  /// 获取对应的 StatusNote 值
  StatusNote get stateNote {
    switch (this) {
      case StateNoteHive.unspecified:
        return StatusNote.undefined;
      case StateNoteHive.pinned:
        return StatusNote.pinned;
      case StateNoteHive.archived:
        return StatusNote.archived;
      case StateNoteHive.trash:
        return StatusNote.trash;
    }
  }
}