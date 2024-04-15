import 'package:flutter/material.dart'
    show ScaffoldMessenger, ScaffoldMessengerState, SnackBar;
import 'package:flutter/widgets.dart' show BuildContext, Text;
import 'package:get/get.dart';

extension ScaffoldMessengerStateExt on ScaffoldMessengerState {
  void showText(String text) {
    showSnackBar(SnackBar(content: Text(text.tr)));
  }
}

extension BuildContextExt on BuildContext {
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
}
