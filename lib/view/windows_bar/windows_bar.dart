import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:note/core/core.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isMaximized = false;

  double getIconSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.02; // 计算原始大小
    if (iconSize < 40.0) {
      iconSize = 40.0; // 最小值
    } else if (iconSize > 50.0) {
      iconSize = 50.0; // 最大值
    }
    return iconSize;
  }

  double getTextSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double textSize = screenWidth * 0.02; // 计算原始大小
    if (textSize < 16.0) {
      textSize = 16.0; // 最小值
    } else if (textSize > 24.0) {
      textSize = 24.0; // 最大值
    }
    return textSize;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (defaultTargetPlatform == TargetPlatform.windows) {
          return Container(
            height: widget.preferredSize.height,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey, // 下划线颜色
                  width: 0.5, // 下划线宽度
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Image.asset(
                    AppIcons.logo,
                    width: getIconSize(context),
                    height: getIconSize(context),
                  ),
                ),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: getTextSize(context)),
                ),
                Expanded(
                  child: GestureDetector(
                    onPanDown: (DragDownDetails details) {
                      WindowManager.instance.startDragging();
                    },
                    child: Container(color: Colors.transparent),
                  ),
                ),
                Row(
                  children: <Widget>[
                    _buildSettingButton(),
                    _buildMinButton(),
                    _buildMaxButton(),
                    _buildCloseButton(),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildSettingButton() {
    return Tooltip(
      message: '设置',
      child: IconButton(
        icon: AppIcons.setting,
        onPressed: () {
          Get.toNamed(AppRouterName.setting.path);
        },
      ),
    );
  }

  Widget _buildMinButton() {
    return Tooltip(
      message: '最小化',
      child: IconButton(
        icon: AppIcons.min,
        onPressed: WindowManager.instance.minimize,
      ),
    );
  }

  Widget _buildMaxButton() {
    return Tooltip(
      message: '最大化',
      child: IconButton(
        icon: AppIcons.max,
        onPressed: () {
          if (_isMaximized) {
            WindowManager.instance.restore();
          } else {
            WindowManager.instance.maximize();
          }
          setState(() {
            _isMaximized = !_isMaximized;
          });
        },
      ),
    );
  }

  Widget _buildCloseButton() {
    return Tooltip(
      message: '关闭',
      child: IconButton(
        icon: AppIcons.close,
        onPressed: WindowManager.instance.close,
      ),
    );
  }
}
