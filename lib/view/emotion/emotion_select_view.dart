import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/core.dart';

class EmotionSelector extends StatelessWidget {
  final Note note; // 添加一个 Note 参数
  // ignore: use_super_parameters
  const EmotionSelector({Key? key, required this.note})
      : super(key: key); // 在构造函数中初始化 Note

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmotionController>(
      builder: (controller) {
        return IconButton(
          icon: SvgPicture.asset(
            EmotionIcons.getSvgPath(controller.currentEmotionStatus.value),
          ),
          onPressed: () {
            _showEmotionSelectionDialog(context);
          },
          tooltip: I18nContent.selectEmotion.tr,
        );
      },
    );
  }

  void _showEmotionSelectionDialog(BuildContext context) {
    final EmotionController emotionController = Get.find<EmotionController>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(I18nContent.selectEmotion.tr),
          content: SingleChildScrollView(
            child: Column(
              children: EmotionIcons.getAllIcons().map((icon) {
                return ListTile(
                  leading: SvgPicture.asset(
                    icon.svgPath,
                    width: 40,
                    height: 40,
                  ),
                  title: Text(icon.emotion.toString().tr),
                  onTap: () {
                    emotionController.toggleEmotionIconsStatus(note,icon.emotion);
                    // print((emotionController.currentEmotionIconStatus.value
                            // as ToggleEmotionIconsState)
                        // .currentEmotionStatus);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
