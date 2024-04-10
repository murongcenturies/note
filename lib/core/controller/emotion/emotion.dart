import 'package:get/get.dart';

import '../../core.dart';

class EmotionController extends GetxController {
  // 当前情绪状态
  final Rx<Emotion> _currentEmotion = Emotion.calm.obs;

  // 获取当前情绪状态
  Emotion get currentEmotion => _currentEmotion.value;

  // 切换情绪状态
  void toggleEmotion(Emotion newEmotion) {
    _currentEmotion.value = newEmotion;
  }
}