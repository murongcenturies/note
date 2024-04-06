import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:note/core/core.dart';
class LoginController  extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // 表单全局键
  RxBool emailEmpty = false.obs;
  RxBool passwordEmpty = false.obs;
  RxString emailError = RxString('');
  RxString passwordError = RxString('');
  RxBool isLoading = false.obs;

  // 显示错误消息函数
  void showError(String field) {
    if (field == 'email') {
      emailEmpty.value = true;
      emailError.value = "Email cannot be empty";
    } else if (field == 'password') {
      passwordEmpty.value = true;
      passwordError.value = "Password cannot be empty";
    }
  }

  // 隐藏错误消息函数
  void hideError(String field) {
    if (field == 'email') {
      emailEmpty.value = false;
      emailError.value = '';
    } else if (field == 'password') {
      passwordEmpty.value = false;
      passwordError.value = '';
    }
  }

  // 登录函数
  void signIn(BuildContext context) async {
    emailEmpty.value = false;
    passwordEmpty.value = false;

    if (formKey.currentState!.validate()) {
      isLoading.value = true; // 显示加载动画

      // 模拟登录请求，实际情况应该是调用接口或其他验证逻辑
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false; // 隐藏加载动画
      Get.toNamed(AppRouterName.home.path); // 登录成功跳转到首页
    } else {
      showError('email');
      showError('password');
    }
  }
}
