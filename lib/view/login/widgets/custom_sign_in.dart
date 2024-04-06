import 'package:flutter/material.dart';

import 'sign_in_form.dart';

/// 自定义登录对话框
///
/// [context] 上下文对象，表示当前的构建上下文
/// [onClosed] 对话框关闭时的回调函数
Future<void> customSigninDialog(BuildContext context,
    {ValueChanged? onClosed}) async {
  await showGeneralDialog(
      barrierDismissible: true,
      // 是否可以点击背景关闭对话框
      barrierLabel: "Sign up",
      // 背景语义标签
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      // 动画时长
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) {
        final size = MediaQuery.of(context).size; // 获取屏幕大小
        const double dialogHeight = 500; // 对话框高度为屏幕高度的90%
        final double dialogWidth =
            size.width > 600 ? 600 : size.width; // 对话框宽度最大为600，超过屏幕宽度则设置为屏幕宽度

        return Center(
          child: Container(
            height: dialogHeight,
            width: dialogWidth,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false, // 避免键盘弹出时溢出错误
              body: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Column(
                    children: [
                      Text(
                        "Sign In", // 登录标题
                        style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                      ),
                      SignInForm(), // 登录表单
                      Divider(),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Discover more possibilities, start here",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // 创建一个居中在屏幕底部的关闭按钮
                  Positioned(
                    // 将圆形水平居中
                    left: 0,
                    right: 0,
                    // 调整圆形距离底部的位置
                    bottom: -48,
                    child: CircleAvatar(
                      // 设置圆形半径大小
                      radius: 16,
                      //设置圆形的背景颜色
                      backgroundColor: Colors.white,
                      //创建一个带有图标的按钮
                      child: IconButton(
                          //设置按钮的点击事件处理程序。该处理程序将关闭当前路由
                          onPressed: () => Navigator.of(context).pop(),
                          //设置按钮的位置大小和颜色
                          icon: Transform.translate(
                            offset: const Offset(0, -4),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.close,
                                color: Colors.redAccent,
                                size: 24,
                              ),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
  if (onClosed != null) {
    onClosed(null); // 在对话框关闭后执行回调函数
  }
}
