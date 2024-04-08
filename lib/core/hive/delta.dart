import 'dart:convert';

import 'package:flutter_quill/quill_delta.dart';
import 'package:hive/hive.dart';

/// DeltaAdapter类是Delta类型的适配器，用于Hive数据库的读写操作
class DeltaAdapter extends TypeAdapter<Delta> {
  /// 定义类型ID
  @override
  final typeId = 3;

  /// 从Hive数据库读取Delta对象
  @override
  Delta read(BinaryReader reader) {
    // // 读取字符串
    // final jsonString = reader.readString();
    // // 将字符串解码为JSON
    // final jsonData = jsonDecode(jsonString);
    // // 从JSON创建Delta对象
    // return Delta.fromJson(jsonData);
     var jsonString = reader.readString();
    return Delta.fromJson(json.decode(jsonString));
  }

  // 将Delta对象写入Hive数据库
  @override
  void write(BinaryWriter writer, Delta obj) {
    // // 将Delta对象转换为JSON字符串
    // final jsonString = jsonEncode(obj.toJson());
    // // 写入字符串
    // writer.writeString(jsonString);
     var jsonString = json.encode(obj.toJson());
    writer.writeString(jsonString);
  }
}