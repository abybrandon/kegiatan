import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../controller/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: bgWhite,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 20.w, top: 45.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Remix.arrow_left_line,
                        size: 20.sp,
                        color: bgRed,
                      ),
                    ),
                    20.w.widthBox,
                    Text(
                      'Change Password',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: bgRed,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                40.h.heightBox,
                Text('Change Your Password',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: Config.semiBold,
                        color: bgRed)),
                4.h.heightBox,
                Text('Make a strong password',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: Config.reguler,
                        color: bgGreyLite)),
                16.h.heightBox,
                Text('Old Password',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: Config.medium,
                        color: basicBlack)),
                8.h.heightBox,
                Obx(
                  () => TextField(
                    controller: controller.controllerOldPassword,
                    obscureText: controller.isObscure.value,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: bgBlue),
                        ),
                        hintText: 'Enter Old Password',
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.isObscure.value =
                                !controller.isObscure.value;
                          },
                          child: Icon(
                            controller.isObscure.value
                                ? FeatherIcons.eye
                                : FeatherIcons.eyeOff,
                          ),
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: basicBlack)),
                        hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: Config.reguler,
                            color: basicBlack)),
                  ),
                ),
                19.h.heightBox,
                _TextFieldCustom(
                    controller: controller.controllerNewPassword,
                    isObscure: controller.isObscure,
                    isPasswordMatch: controller.isPasswordMatch,
                    tittle: 'New Password',
                    hint: 'Enter New Password'),
                19.h.heightBox,
                _TextFieldCustom(
                    controller: controller.controllerConfirmPassword,
                    isObscure: controller.isObscure,
                    isPasswordMatch: controller.isPasswordMatch,
                    tittle: 'Confirm New Password',
                    hint: 'Enter Confirm Password'),
                10.h.heightBox,
                Obx(() => controller.isPasswordMatch.value
                    ? Text(
                        "Password didn't match",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: bgRed,
                            fontWeight: Config.semiBold),
                      )
                    : SizedBox.shrink())
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: InkWell(
                onTap: () {
                  controller.checkPasswordMatch();
                },
                child: Container(
                  height: 50.h,
                  width: Get.width,
                  color: bgRed,
                  child: Center(
                      child: Text(
                    'Save Changes',
                    style: TextStyle(
                      color: bgWhite,
                      fontWeight: Config.semiBold,
                    ),
                  )),
                ),
              ))
        ],
      ),
    ));
  }
}

class _TextFieldCustom extends StatelessWidget {
  const _TextFieldCustom(
      {super.key,
      required this.controller,
      required this.isObscure,
      required this.isPasswordMatch,
      required this.tittle,
      required this.hint});
  final String tittle;
  final String hint;
  final RxBool isPasswordMatch;
  final RxBool isObscure;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tittle,
            style: TextStyle(
                fontSize: 16.sp, fontWeight: Config.medium, color: basicBlack)),
        8.h.heightBox,
        Obx(
          () => TextField(
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: Config.reguler,
              color: isPasswordMatch.value ? bgRed : basicBlack,
            ),
            obscureText: isObscure.value,
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: isPasswordMatch.value ? bgRed : basicBlack),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: isPasswordMatch.value ? bgRed : bgBlue),
              ),
              hintText: hint,
              suffixIcon: InkWell(
                onTap: () {
                  isObscure.value = !isObscure.value;
                },
                child: Icon(
                  isObscure.value ? FeatherIcons.eye : FeatherIcons.eyeOff,
                ),
              ),
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: Config.reguler,
                color: basicBlack,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
