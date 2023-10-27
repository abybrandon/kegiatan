import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/custom_textfield.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../controller/change_username_controller.dart';

class ChangeUsernameView extends GetView<ChangeUsernameController> {
  const ChangeUsernameView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: bgWhite,
      body: Column(
        children: [
          Expanded(
            child: Padding(
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
                        'Change Username',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: bgRed,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  40.h.heightBox,
                  Text('Update Your Username',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: Config.semiBold,
                          color: bgRed)),
                  4.h.heightBox,
                  Text('Your Username, Your Story',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: Config.reguler,
                          color: bgGreyLite)),
                  16.h.heightBox,
                  Text('New Username',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: Config.medium,
                          color: basicBlack)),
                  8.h.heightBox,
                  TextField(
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: bgBlue),
                        ),
                        hintText: 'Enter New Username',
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: basicBlack)),
                        hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: Config.reguler,
                            color: basicBlack)),
                  ),
                  19.h.heightBox,
                  Text('Confirmation Password',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: Config.medium,
                          color: basicBlack)),
                  8.h.heightBox,
                  Obx(
                    () => TextField(
                      obscureText: controller.isObscure.value,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: bgBlue),
                          ),
                          hintText: 'Enter Password',
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
                ],
              ),
            ),
          ),
          Container(
            height: 50.h,
            width: Get.width,
            color: bgRed,
            child: Center(
                child: Text(
              'Update Username',
              style: TextStyle(
                color: bgWhite,
                fontWeight: Config.semiBold,
              ),
            )),
          )
        ],
      ),
    ));
  }
}
