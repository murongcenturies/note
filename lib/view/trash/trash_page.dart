import 'package:flutter/material.dart';
import 'package:note/view/home/widgets/widgets.dart';
import 'package:note/core/core.dart';
import 'package:note/view/views.dart';
import 'package:get/get.dart';

// 主页 (显示所有笔记列表)
class TrashPage extends StatelessWidget {
    // HomePage({super.key});

  final DrawerNavigationController drawerController =
      Get.put(DrawerNavigationController());
  late final NoteController _controller ;
    TrashPage({super.key}) {
    final selectedView = drawerController.convertToDrawerSectionView(drawerController.selectedNavItem.value);
    print(selectedView);
     // 获取视图名称
    String name = selectedView.toString().split('.').last;
    // 初始化 NoteController 并将其放入 GetX 管理
    _controller = Get.put(NoteController(selectedView), tag: name);
  }

  @override
  Widget build(BuildContext context) {
    // final state = Get.find<NoteController>().noteState;
    return Scaffold(
      //自定义windows_bar
      appBar: const CustomAppBar(title: 'sparkler'),
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
            // print(state);
            if (state is LoadingState) {
              print(state);
              return CommonLoadingNotes(state.drawerSectionView);
            }
          else if (state is EmptyNoteState) {
              // print(state.drawerSectionView);
              // return const CommonEmptyNotes(DrawerSectionView.home);
              return  CommonEmptyNotes(state.drawerSectionView);
            } 
            else if (state is ErrorState) {
              // print(state);
              return CommonEmptyNotes(state.drawerSectionView);
            }

            else if (state is NotesViewState) {
              return SliverNotes(
                child: CommonNotesView(
                  drawerSection: DrawerSectionView.archive,
                  otherNotes: state.otherNotes,
                  pinnedNotes: state.pinnedNotes,
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
}// TODO Implement this library.