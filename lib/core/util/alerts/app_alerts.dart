// 导入 Flutter 和相关库
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// 导入 core 库
import '../../core.dart';

// 不可变类 AppAlerts，用于显示应用内弹窗
@immutable
class AppAlerts {
  const AppAlerts._(); // 私有构造函数

  // 内部方法，用于显示 SnackBar
  static void _displaySnackBar(
    BuildContext context,
    String message, // 消息内容
    String? actionLabel, // 操作按钮的文字
    void Function()? onPressed, // 操作按钮的回调函数
  ) {
    // 移除之前的 SnackBar
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      // 显示新的 SnackBar
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: context.textTheme.bodyMedium),
          // 内容文本
          duration: const Duration(seconds: 2),
          // 显示时长
          behavior: SnackBarBehavior.floating,
          // 浮动显示
          backgroundColor: context.colorScheme.primaryContainer,
          // 背景色
          action: onPressed != null // 如果存在操作按钮
              ? SnackBarAction(
                  textColor: context.colorScheme.onBackground, // 文字颜色
                  label: actionLabel!, // 操作按钮文字
                  onPressed: onPressed, // 操作按钮回调
                )
              : null, // 否则不显示操作按钮
        ),
      );
  }

  // 显示普通消息弹窗
  static void displaySnackbarMsg(BuildContext context, String message) {
    _displaySnackBar(context, message, null, null);
  }

  // 显示撤销移动笔记的弹窗，并提供撤销操作
  static void displaySnackarUndoMove(BuildContext context, String message) {
    _displaySnackBar(
      context,
      message,
      'Undo', // 操作按钮文字
      () {
        Get.find<NoteController>(tag: 'home').undoMoveNote();
      }
    );
  }

  // 显示回收站弹窗
  static void displaySnackarRecycle(BuildContext context, String message) {
    // _displaySnackBar(
    //   context,
    //   message,
    //   'Recycle', // 操作按钮文字
    //   () {
    //     // 获取当前笔记状态
    //     final noteStatusState = context.read<StatusIconsCubit>().state;
    //
    //     // 如果处于只读状态
    //     if (noteStatusState is ReadOnlyState) {
    //       final currentNote = noteStatusState.currentNote;
    //
    //       // 将笔记移动到未定义状态 (相当于回收站)
    //       context
    //           .read<NoteBloc>()
    //           .add(MoveNote(currentNote, StatusNote.undefined));
    //     }
    //   },
    // );
  }

  // 显示删除笔记确认对话框
  static Future<void> showAlertDeleteDialog(
    BuildContext context,
    Note note,
  ) async {
    // 取消按钮
    Widget cancelButton = TextButton(
      child: const Text('NO'),
      onPressed: () {
        // 关闭两个弹窗 (对话框和 SnackBar)
        // context.pop();
        // context.pop();
      },
    );

    // 删除按钮
    Widget deleteButton = TextButton(
      child: const Text('YES'),
      onPressed: () {
        // 关闭两个弹窗 (对话框和 SnackBar)
        // context.pop();
        // context.pop();

        // 触发删除笔记事件
        // context.read<NoteBloc>().add(DeleteNote(note.id));

        // 刷新笔记列表
        // context.read<NoteBloc>().add(RefreshNotes(DrawerSelect.drawerSection));
      },
    );

    // 构建 AlertDialog
    AlertDialog alert = AlertDialog(
      // backgroundColor: ColorNote.getColor(context, note.colorIndex),
      // 背景色根据笔记颜色设置
      content: const Text('Are you sure you want to delete this Note?'),
      // 提示文本
      actions: [
        deleteButton,
        cancelButton,
      ],
    );

    // 显示对话框
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
