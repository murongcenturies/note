import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:note/core/core.dart';

// 登录表单部件
class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();

    return Stack(
      children: [
        Form(
          key: loginController.formKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  I18nContent.email.tr,
                  style: const TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        loginController.showError('email');
                        return I18nContent.enterEmail.tr;
                      } else {
                        loginController.hideError('email');
                        return null;
                      }
                    },
                    onSaved: (email) {},
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: AppIcons.email,
                      ),
                      errorText: loginController.emailEmpty.value
                          ? loginController.emailError.value
                          : null,
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                 Text(
                  I18nContent.password.tr,
                  style: const TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        loginController.showError('password');
                        return I18nContent.enterPassword.tr;
                      } else {
                        loginController.hideError('password');
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: AppIcons.password),
                      errorText: loginController.passwordEmpty.value
                          ? loginController.passwordError.value
                          : null,
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      loginController.signIn(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF77D8E),
                      minimumSize: const Size(double.infinity, 56),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                    icon: AppIcons.leftBack,
                    label: Obx(() {
                      return loginController.isLoading.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0,
                              ),
                            )
                          :  Text(
                              I18nContent.signIn.tr,
                              style: const TextStyle(fontSize: 18),
                            );
                    }),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
