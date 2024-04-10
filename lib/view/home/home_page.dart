import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'widgets/widgets.dart';
import 'package:note/core/core.dart';
import 'package:note/view/views.dart';
import 'package:get/get.dart';

// 主页 (显示所有笔记列表)
class HomePage extends StatelessWidget {
  // HomePage({super.key});

  final DrawerNavigationController drawerController =
      Get.put(DrawerNavigationController());
  final HomeController homeController = Get.put(HomeController());
  final StatusIconsController noteStatue = Get.put(StatusIconsController());
  final EmotionController emotionController = Get.put(EmotionController());
  late final NoteController _controller;
  HomePage({super.key}) {
    // 获取当前选中的视图
    final selectedView = drawerController
        .convertToDrawerSectionView(drawerController.selectedNavItem.value);
    // 获取视图名称
    String name = selectedView.toString().split('.').last;
    // 初始化 NoteController 并将其放入 GetX 管理
    _controller = Get.put(NoteController(selectedView), tag: name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 关联 GlobalKey<ScaffoldState> 对象
      // key: drawerController.scaffoldKey,
      //自定义windows_bar
      appBar: const CustomAppBar(title: 'sparkler'),
      // 抽屉导航
      drawer: const AppDrawer(),
      // 浮动操作按钮 (用于新增笔记)
      floatingActionButton: _buildFloatingActionButton(context),
      // 显示 ParallaxRain 效果
      body: Stack(
        children: <Widget>[
          // 添加背景图片的 SizedBox
          const SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppIcons.cloud), // 背景图片路径
                  fit: BoxFit.fill, // 适应方式，可以根据需求调整
                ),
              ),
            ),
          ),
          // 根据状态显示不同的组件
          Obx(() {
            final state = _controller.noteState.value;
            if (state is LoadingState) {
              return CommonLoadingNotes(state.drawerSectionView);
            } else if (state is EmptyNoteState) {
              return CommonEmptyNotes(state.drawerSectionView);
            } else if (state is ErrorState) {
              return CommonEmptyNotes(state.drawerSectionView);
            } else if (state is NotesViewState) {
              return SliverNotes(
                child: CommonNotesView(
                  drawerSection: DrawerSectionView.home,
                  otherNotes: state.otherNotes,
                  pinnedNotes: state.pinnedNotes,
                ),
              );
            }
            displayNotesMsg(state);
            // 默认返回空占位符
            return const SizedBox.shrink();
          }),
          // ),
        ],
      ),
    );
  }

  void displayNotesMsg(state) {
    if (state is SuccessState) {
      // 刷新笔记列表并显示成功信息
      _controller.refreshNotes();
      print(state.message);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppAlerts.displaySnackbarMsg(Get.context!, state.message);
      });
    } else if (state is ToggleSuccessState) {
      print(state.message);
      // 显示可撤销操作的 Snackbar
       SchedulerBinding.instance.addPostFrameCallback((_) {
      AppAlerts.displaySnackarUndoMove(Get.context!, state.message);
        });
    } else if (state is EmptyInputsState) {
      // 显示空输入提示信息
      // AppAlerts.displaySnackbarMsg(Get.context, _controller.noteState.value.message);
    }
    // else if (_controller.noteState.value is GoPopNoteState) {
    // 刷新笔记列表
    // refreshNotes(DrawerSelect.drawerSection);
    // }
    else if (state is GetNoteByIdState) {
      print(state.note);
      // 处理获取单个笔记信息的逻辑
      _getNoteByIdState(state.note);
    }
  }

  // 处理获取单个笔记信息的逻辑
  void _getNoteByIdState(Note note) {
    Future.delayed(Duration.zero, () {
      // 更新图标状态
      noteStatue.toggleIconsStatus(note);
    });

    // 导航到笔记详情页面
    // Get.toNamed(AppRouterName.note.path, arguments: note);
    _navigateToNoteDetail(note);
  }

  void _navigateToNoteDetail(Note note) async {
    await Future.delayed(Duration.zero);
    Get.toNamed(AppRouterName.note.path, arguments: note);
  }

  // 构建浮动操作按钮
  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        // 去掉阴影
        elevation: 0,
        child: AppIcons.add,
        // 点击时添加新笔记
        onPressed: () {
          _controller.getById(''); // 获取空白笔记
        });
  }
}
