import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallax_rain/parallax_rain.dart';
import './widgets/widgets.dart';

import 'package:note/core/core.dart';
import 'package:note/view/views.dart';

// 登录界面
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //获取屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:  CustomAppBar(title: I18nContent.title.tr),
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
          Positioned(
            left: 0,
            top: 0,
            // 调整这里的值来避开 CustomWindowTitleBar 的高度
            right: 0,
            bottom: 0,
            child: SizedBox(
              // 调整高度，使 ParallaxRain 不覆盖 CustomWindowTitleBar
              height: MediaQuery.of(context).size.height -
                  30, // 减去 CustomWindowTitleBar 的高度
              child: ParallaxRain(
                dropColors: const [
                  Colors.blueGrey,
                ],
              ),
            ),
          ),
          const WelcomeBackScreen(),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.2, // 调整按钮宽度
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: screenWidth * 0.025,
                ),
                // 添加底部间距
                child: ElevatedButton(
                  onPressed: () {
                    customSigninDialog(context, onClosed: (dynamic _) {
                      // 在对话框关闭后执行一些操作
                      // print('Dialog Closed');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.001, // 根据屏幕宽度调整垂直内边距
                      horizontal: screenWidth * 0.001, // 根据屏幕宽度调整水平内边距
                    ), // Adjust button size
                    textStyle: TextStyle(
                      fontSize: screenWidth * 0.025,
                    ), // Adjust button text size
                  ),
                  child: Text(
                    I18nContent.start.tr,
                    style: TextStyle(
                      fontSize: screenWidth * 0.015,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
