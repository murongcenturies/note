import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTextWidget extends StatelessWidget {
  const AnimatedTextWidget({super.key});

  double getTextSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double textSize = screenWidth * 0.01; // 计算原始大小
    if (textSize < 20.0) {
      textSize = 40.0; // 最小值
    } else if (textSize > 70.0) {
      textSize = 90.0; // 最大值
    }
    return textSize;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      // pause: const Duration(milliseconds: 100),
      repeatForever: true,
      pause: Duration.zero, // 消除延迟
      animatedTexts: [
        ColorizeAnimatedText(
          'Welcome Back!',
          textStyle: TextStyle(fontSize: getTextSize(context)),
          colors: [
            const Color(0xFFD8E7CB),
            Colors.red.shade200,
            Colors.orange,
            Colors.blue,
            Colors.indigo,
            Colors.purple.shade100,
          ],
          speed: const Duration(milliseconds: 400),
        ),
        ColorizeAnimatedText(
          'Every idea deserves to be written down!',
          textStyle:
              TextStyle(fontSize: getTextSize(context) * 0.6), // 使用比例调整第二个文本的大小
          colors: [
            const Color(0xFFD8E7CB),
            Colors.red.shade200,
            Colors.orange,
            Colors.blue,
            Colors.indigo,
            Colors.purple.shade100,
          ],
          // speed: const Duration(milliseconds: 250),
        ),
      ],
    );
  }
}

class WelcomeBackScreen extends StatelessWidget {
  const WelcomeBackScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Positioned(
      left: 0,
      top: 0,
      right: 0,
      bottom: 0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 动画文本
            AnimatedTextWidget(),
          ],
        ),
      ),
    );
  }
}
