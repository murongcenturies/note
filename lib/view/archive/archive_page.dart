import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:note/view/home/widgets/widgets.dart';
import 'package:note/core/core.dart';
import 'package:note/view/views.dart';
import 'package:get/get.dart';

import 'app_bar_archive.dart';

// 主页 (显示所有笔记列表)
class ArchivePage extends StatelessWidget {
  // HomePage({super.key});

   final DrawerNavigationController drawerController =
      Get.put(DrawerNavigationController());
  final StatusIconsController noteStatue = Get.put(StatusIconsController());
    final EmotionController emotionController = Get.put(EmotionController());
  late final NoteController _controller;
  ArchivePage({super.key}) {
    final selectedView = drawerController
        .convertToDrawerSectionView(drawerController.selectedNavItem.value);
    // print(selectedView);
    // 获取视图名称
    String name = selectedView.toString().split('.').last;
    // 初始化 NoteController 并将其放入 GetX 管理
    _controller = Get.put(NoteController(selectedView), tag: name);
  }

  @override
  Widget build(BuildContext context) {
    // final state = Get.find<NoteController>().noteState;
    return Scaffold(
      // 使用自定义的归档页面 AppBar
      appBar: const AppBarAchieve(),
      // 使用应用程序的抽屉导航
      drawer: const AppDrawer(),
      // 显示 ParallaxRain 效果
      body: Stack(
        children: <Widget>[
          // 添加背景图片
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppIcons.cloud), // 背景图片路径
                  fit: BoxFit.fill, // 适应方式，可以根据需求调整
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .background
                      .withOpacity(0.5), // 使用主题背景颜色
                ),
              ),
            ),
          ),
          // 根据状态显示不同的组件
          Obx(() {
            final state = _controller.noteState.value;
            displayNotesMsg(state);
            // print(_controller.selectedNavItem);
            if (state is LoadingState) {
              // print(state);
              return CommonLoadingNotes(state.drawerSectionView);
            } else if (state is EmptyNoteState) {
              return CommonEmptyNotes(state.drawerSectionView);
            } else if (state is ErrorState) {
              // print(state);
              return CommonEmptyNotes(state.drawerSectionView);
            } else if (state is NotesViewState) {
              return Padding(
                padding: const EdgeInsets.only(top: 10.0), // 顶部边距
                child: CommonNotesView(
                  drawerSection: DrawerSectionView.archive,
                  otherNotes: state.otherNotes,
                  pinnedNotes: const [], // 不展示置顶笔记
                ),
              );
            }
            // 默认返回空占位符
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  // 处理笔记状态变化
  void displayNotesMsg(state) {
    if (state is SuccessState) {
      // 刷新笔记列表并显示成功信息
      _controller.refreshNotes();
      // print(state.message);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppAlerts.displaySnackbarMsg(Get.context!, state.message);
      });
    } else if (state is ToggleSuccessState) {
      // print(state.message);
      // 显示可撤销操作的 Snackbar
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppAlerts.displaySnackarUndoMove(Get.context!, state.message);
        _controller.refreshNotes();
      });
    }  else if (state is GoPopNoteState) {
      // 刷新笔记列表
      _controller.refreshNotes();
    } else if (state is GetNoteByIdState) {
      // print(state.note);
      // 处理获取单个笔记信息的逻辑
      _getNoteByIdState(state.note);
    }
  }

  // 处理获取单个笔记信息的逻辑
  void _getNoteByIdState(Note note) {
    Future.delayed(Duration.zero, () {
      // 更新图标状态
      
      noteStatue.toggleIconsStatus(note);
      emotionController.toggleEmotionIconsStatus(note, note.emotion);
    });

    // 导航到笔记详情页面
    _navigateToNoteDetail(note);
  }

// 导航到笔记详情页面
  void _navigateToNoteDetail(Note note) async {
    // print(_controller.selectedNavItem);
    await Future.delayed(Duration.zero);
        Get.toNamed(
      AppRouterName.note.path,
      arguments: {
        'note': note,
        'noteController': _controller,
      },
    );
  }
}
