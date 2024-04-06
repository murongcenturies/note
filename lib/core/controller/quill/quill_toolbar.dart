import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxBool useCustomQuillToolbar = true.obs;


  void updateUseCustomQuillToolbar(bool value) {
    useCustomQuillToolbar.value = value;
  }
}
