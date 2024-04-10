import 'package:equatable/equatable.dart';
import 'package:flutter_quill/quill_delta.dart';

import '../../../core/core.dart';

// 定义笔记类 (继承自 Equatable)
class Note extends Equatable {
  // 笔记 ID
  final String id;

  // 笔记内容
  final Delta content;

  // 笔记修改时间
  final DateTime modifiedTime;

  // 笔记状态
  final StatusNote stateNote;

  //笔记情绪
  final Emotion emotion;

  // 构造方法
  const Note({
    required this.id,
    required this.content,
    required this.modifiedTime,
    required this.stateNote,
    required this.emotion,
  });

  // 复制方法 (用于创建新的 Note 对象)
  Note copyWith({
    String? id,
    Delta? content,
    DateTime? modifiedTime,
    StatusNote? statusNote,
    Emotion? emotion,
  }) {
    return Note(
      id: id ?? this.id,
      content: content ?? this.content,
      modifiedTime: modifiedTime ?? this.modifiedTime,
      // ignore: unnecessary_this
      stateNote: statusNote ?? this.stateNote,
      emotion: emotion ?? this.emotion,
    );
  }

  // 空笔记构造方法 (用于创建空笔记对象)
  Note.empty({
    String? id,
    Delta? content,
    DateTime? modifiedTime,
    this.stateNote = StatusNote.undefined,
    this.emotion = Emotion.joyful,
  })  : id = id ?? UUIDGen.generate(),
        content = content ?? Delta(),
        modifiedTime = modifiedTime ?? DateTime.now() {
    // print('Note.empty');
  }

  // 覆写 props 方法 (用于比较对象是否相等)
  @override
  List<Object?> get props => [id, content, modifiedTime, stateNote, emotion];
}

// 定义笔记模型类 (继承自 Note)
class NoteModel extends Note {
  const NoteModel({
    required super.id,
    required super.content,
    required super.modifiedTime,
    required super.stateNote,
    required super.emotion,
  });
}
