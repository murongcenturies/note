import 'package:hive/hive.dart';
// 使用 Hive 进行序列化 (typeId 为 2)
@HiveType(typeId: 2)
// 定义笔记状态枚举类
enum StateNoteHive {
  // 未指定 (HiveField 0)
  @HiveField(0)
  unspecified,

  // 已固定 (HiveField 1)
  @HiveField(1)
  pinned,

  // 已归档 (HiveField 2)
  @HiveField(2)
  archived,

  // 已放入回收站 (HiveField 3)
  @HiveField(3)
  trash,

  //情绪 (HiveField 4)
  // @HiveField(4)
  // emotion,
}
// StateNoteHive 的适配器类
class StateNoteHiveAdapter extends TypeAdapter<StateNoteHive> {
  // 适配器类型 ID (与枚举类型 ID 一致)
  @override
  final int typeId = 2;

  // 从二进制读取器读取枚举值
  @override
  StateNoteHive read(BinaryReader reader) {
    // 根据读取到的字节值，返回对应的枚举值
    return StateNoteHive.values[reader.readByte()];
  }

  // 向二进制写入器写入枚举值
  @override
  void write(BinaryWriter writer, StateNoteHive obj) {
    // 写入枚举值的索引 (节省空间)
    writer.writeByte(obj.index);
  }
}
