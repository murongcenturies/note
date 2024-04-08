// 引入 Hive 库用于本地存储
import 'package:flutter_quill/quill_delta.dart';
import 'package:hive/hive.dart';

// 引入笔记状态枚举类 (state_note_hive.dart)
import 'state_note_hive.dart';

// 自动生成 Hive 适配代码 (note_hive.g.dart)
part 'hive.g.dart';

// 笔记 Hive 存储对象 (用于序列化和反序列化)
@HiveType(typeId: 0)
class NoteHive extends HiveObject {

  // 笔记 ID (HiveField 0)
  @HiveField(0)
  final String id;

  // 笔记内容 (HiveField 1)
  @HiveField(1)
  final Delta content;

  // 笔记修改时间 (HiveField 4)
  @HiveField(2)
  final DateTime modifiedTime;

  // 笔记状态 (HiveField 5)
  @HiveField(3)
  final StateNoteHive stateNoteHive;

  // 构造方法
  NoteHive({
    required this.id,
    required this.content,
    required this.modifiedTime,
    required this.stateNoteHive,
  });
}