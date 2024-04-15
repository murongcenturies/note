import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/core.dart';

// 笔记页面的 “置顶” 按钮
class IconPinnedStatus extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables, use_super_parameters
  IconPinnedStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatusIconsController>(
      builder: (controller) {
        final currentStatus = controller.currentNoteStatus.value;

        return IconButton(
          icon: Icon(iconCurrentStatus(currentStatus)),
          color: Theme.of(context).iconTheme.color,
          onPressed: () {
            _onTogglePinnedStatus(currentStatus);
          },
          tooltip: currentStatus == StatusNote.pinned
              ? I18nContent.unpinNote.tr
              : I18nContent.pinNote.tr,
        );
      },
    );
  }

  IconData iconCurrentStatus(StatusNote currentStatus) {
    if (currentStatus == StatusNote.pinned) {
      return AppIcons.unPin;
    } else {
      return AppIcons.pin;
    }
  }

  void _onTogglePinnedStatus(StatusNote currentStatus) {
    Get.find<StatusIconsController>().toggleIconPinnedStatus(currentStatus);
    // print(currentStatus);
  }
}
