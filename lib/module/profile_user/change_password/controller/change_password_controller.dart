import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController with StateMixin {

 @override
  void onClose() {
    Get.delete<ChangePasswordController>();
    super.onClose();
  }

  RxBool isObscure = true.obs;

  RxBool isPasswordMatch = false.obs;

  void checkPasswordMatch() {
    final newPassword = controllerNewPassword.value.text;
    final confirmPassword = controllerConfirmPassword.value.text;

    if (newPassword != '' &&
        confirmPassword != '' &&
        newPassword == confirmPassword) {
      isPasswordMatch.value = false;
      print('password  sama');
    } else {
      print('password tidak sama');
      isPasswordMatch.value = true;
    }
  }

  //textfield
  final controllerOldPassword = TextEditingController();

  final controllerNewPassword = TextEditingController();

  final controllerConfirmPassword = TextEditingController();
}
