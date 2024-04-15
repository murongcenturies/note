import 'package:get/get.dart';

import '../../core.dart';

// 情绪图标状态类
class EmotionIconsState {
  // 构造函数
  const EmotionIconsState();
}

// 情绪图标初始状态
class EmotionIconsInitial extends EmotionIconsState {}

// 切换情绪图标状态
class ToggleEmotionIconsState extends EmotionIconsState {
  // 当前笔记对象
  final Note currentNote;
  // 当前情绪状态
  final Emotion currentEmotionStatus;

  // 构造函数
  const ToggleEmotionIconsState({
    required this.currentNote,
    required this.currentEmotionStatus,
  });
}

class EmotionController extends GetxController {
  // 当前笔记对象
  final _currentNote = Note.empty().obs;
  // 当前情绪状态
  final _currentEmotionStatus = Emotion.joyful.obs;

  // 当前情绪图标状态
  final Rx<EmotionIconsState> _currentEmotionIconStatus =
      Rx<EmotionIconsState>(EmotionIconsInitial());

  //获取当前情绪图标状态
  get currentEmotionIconStatus => _currentEmotionIconStatus;
  get currentNote => _currentNote;
  get currentEmotionStatus => _currentEmotionStatus;

  // 切换情绪图标状态
  void toggleEmotionIconsStatus(Note currentNote, Emotion currentEmotionStatus) {
    _currentNote.value = currentNote;
    _currentEmotionStatus.value = currentEmotionStatus;

    _currentEmotionIconStatus.value = ToggleEmotionIconsState(
      currentNote: _currentNote.value,
      currentEmotionStatus: _currentEmotionStatus.value,
    );

    update();
  }
}
