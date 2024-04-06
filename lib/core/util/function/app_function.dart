// 引入相关库
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import"package:note/core/core.dart";

// 应用层函数类
abstract class AppFunction {
//  刷新笔记 (根据抽屉部分加载)
  static Future<void> onRefresh(BuildContext context) async {
    // 调用 NoteController 的刷新笔记方法
    Get.find<NoteController>().refreshNotes();
  }
}
