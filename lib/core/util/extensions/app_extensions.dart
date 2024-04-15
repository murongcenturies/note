import 'package:get/get.dart';
import 'package:note/core/core.dart';
import 'package:flutter/material.dart';
import 'package:note/core/hive/state_note_hive.dart';

import '../../hive/emotion_note_hive.dart';

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
        return I18nContent.note.tr;
      case DrawerViews.archive:
        return I18nContent.archive.tr;
      case DrawerViews.trash:
        return I18nContent.trash.tr;
      case DrawerViews.emotion:
        return I18nContent.emotion.tr;
      case DrawerViews.setting:
        return I18nContent.set.tr;
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

// 在 Emotion 枚举上添加扩展方法
extension EmotionExtension on Emotion {
  // 根据 Emotion 枚举值获取对应的 EmotionHive 值
  EmotionHive get emotionHive {
    switch (this) {
      case Emotion.joyful:
        return EmotionHive.joyful;
      case Emotion.sad:
        return EmotionHive.sad;
      case Emotion.angry:
        return EmotionHive.angry;
      case Emotion.anxious:
        return EmotionHive.anxious;
      case Emotion.calm:
        return EmotionHive.calm;
      case Emotion.worried:
        return EmotionHive.worried;
      case Emotion.surprised:
        return EmotionHive.surprised;
      case Emotion.tired:
        return EmotionHive.tired;
      default:
        throw UnimplementedError('Missing EmotionHive for $this');
    }
  }
}

// 在 EmotionHive 枚举上添加扩展方法
extension EmotionHiveExtension on EmotionHive {
  // 根据 EmotionHive 枚举值获取对应的 Emotion 值
  Emotion get emotion {
    switch (this) {
      case EmotionHive.joyful:
        return Emotion.joyful;
      case EmotionHive.sad:
        return Emotion.sad;
      case EmotionHive.angry:
        return Emotion.angry;
      case EmotionHive.anxious:
        return Emotion.anxious;
      case EmotionHive.calm:
        return Emotion.calm;
      case EmotionHive.worried:
        return Emotion.worried;
      case EmotionHive.surprised:
        return Emotion.surprised;
      case EmotionHive.tired:
        return Emotion.tired;
      default:
        throw UnimplementedError('Missing Emotion for $this');
    }
  }
}