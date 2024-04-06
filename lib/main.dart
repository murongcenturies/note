import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:note/app/app.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化窗口管理器（仅在Windows平台）
  if (Platform.isWindows) {
    await _initializeWindowManager();
  }

  runApp(NoteApp());
}

// 初始化窗口管理器
Future<void> _initializeWindowManager() async {
  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(
    size: Size(1200, 800),
    center: true,
    backgroundColor: Colors.white,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  // 等待窗口准备好显示并显示窗口
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

