import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:note/core/core.dart';

enum AppLanguage { en, zh }

class TranSlationController extends GetxController {
  // final RxString currentLanguage = 'en'.obs;
  Rx<AppLanguage> currentLanguage = AppLanguage.en.obs;

  // 修改语言
  void changeLanguage(AppLanguage language) {
    currentLanguage.value = language;
    Get.updateLocale(Locale(language.toString().split('.').last));
  }

  // 切换语言
  void toggleLanguage() {
  if (currentLanguage.value == AppLanguage.en) {
    currentLanguage.value = AppLanguage.zh;
    Get.updateLocale(const Locale('zh'));
  } else {
    currentLanguage.value = AppLanguage.en;
    Get.updateLocale(const Locale('en'));
  }
  }

  getIcon() {
    switch (Get.locale!.languageCode) {
      case 'en':
        currentLanguage.value = AppLanguage.en;
        break;
      case 'zh':
        currentLanguage.value = AppLanguage.zh;
        break;
    }
    print(currentLanguage.value.toString());
    return Get.locale!.languageCode == 'en' ? AppIcons.en : AppIcons.zh;
  }
}
