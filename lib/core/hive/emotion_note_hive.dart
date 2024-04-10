import 'package:hive/hive.dart';

// 情绪标签枚举类型
@HiveType(typeId: 4) // 唯一typeId
enum EmotionHive {
  // 喜悦
  @HiveField(0)
  joyful,
  // 悲伤
  @HiveField(1)
  sad,
  // 生气
  @HiveField(2)
  angry,
  // 焦虑
  @HiveField(3)
  anxious,
  // 平静
  @HiveField(4)
  calm,
  // 担忧
  @HiveField(5)
  worried,
  // 惊讶
  @HiveField(6)
  surprised,
  // 疲惫
  @HiveField(7)
  tired,
}

// Emotion 的适配器类
class EmotionAdapter extends TypeAdapter<EmotionHive> {
  // 适配器类型 ID (与枚举类型 ID 一致)
  @override
  final int typeId = 4;

  // 从二进制读取器读取枚举值
  @override
  EmotionHive read(BinaryReader reader) {
    // 根据读取到的字节值，返回对应的枚举值
    return EmotionHive.values[reader.readByte()];
  }

  // 向二进制写入器写入枚举值
  @override
  void write(BinaryWriter writer, EmotionHive obj) {
    // 写入枚举值的索引 (节省空间)
    writer.writeByte(obj.index);
  }
}