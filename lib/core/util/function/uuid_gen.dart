// 引入 UUID 生成库
import 'package:uuid/uuid.dart';

// UUID 生成类用于生成唯一的字符串标识符。
class UUIDGen {
  // 私有构造函数，防止实例化
  UUIDGen._();

  /// 生成 UUID 字符串
  static String generate() {
    // 使用 uuid 库生成 version 1 的 UUID 字符串
    return const Uuid().v1();
  }
}
